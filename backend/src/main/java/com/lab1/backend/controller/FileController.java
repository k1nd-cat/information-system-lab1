package com.lab1.backend.controller;

import com.lab1.backend.dto.DownloadFileRequest;
import com.lab1.backend.dto.FileHistoryRequest;
import com.lab1.backend.dto.MessageResponse;
import com.lab1.backend.service.FileService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Data;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@Data
@RequestMapping("/file")
@Tag(name = "Обработка файлов", description = "Методы для загрузки и выгрузки файлов")
public class FileController {
    private final FileService service;

    @PostMapping("/upload")
    public MessageResponse uploadFile(
            @RequestParam("file") MultipartFile file,
            @RequestHeader("Content-Type") String contentType) throws Exception {
        var fileName = file.getOriginalFilename();
        if (fileName != null) {
            fileName = fileName.replaceFirst("(?i)^.*filename=\"([^\"]+)\".*$", "$1");
            int lastDotIndex = fileName.lastIndexOf('.');
            String baseName = fileName.substring(0, lastDotIndex);
            String extension = fileName.substring(lastDotIndex);
            long timestamp = System.currentTimeMillis();
            fileName = String.format("%s_%d%s", baseName, timestamp, extension);
        }

        return service.uploadFileManager(file.getInputStream(), file.getInputStream(), fileName, contentType);
    }

    @GetMapping("/get-history")
    public List<FileHistoryRequest> getFileHistory() {
        return service.getFileHistory();
    }

    @PostMapping("/download")
    public ResponseEntity<InputStreamResource> downloadFile(@RequestBody DownloadFileRequest downloadFileRequest) throws Exception {
        var fileName = downloadFileRequest.getFilename();
        final var inputStreamResource = service.getFileByName(fileName);
//        HttpHeaders headers = new HttpHeaders();
        int lastUnderscoreIndex = fileName.lastIndexOf('_');
        if (lastUnderscoreIndex != -1) {
            int extensionIndex = fileName.lastIndexOf('.');
            if (extensionIndex != -1 && extensionIndex > lastUnderscoreIndex) {
                fileName = fileName.substring(0, lastUnderscoreIndex) + fileName.substring(extensionIndex);
            }
        }
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + fileName)
                .body(inputStreamResource);
    }
//        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + fileName);
//        headers.add(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE);
//
//        return ResponseEntity.ok()
//                .headers(headers)
//                .body(new InputStreamResource(inputStreamResource));
//    }
}
