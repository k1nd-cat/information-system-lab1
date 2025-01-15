package com.lab1.backend.service;

import com.lab1.backend.dto.FileHistoryRequest;
import com.lab1.backend.dto.MessageResponse;
import com.lab1.backend.entities.FileHistory;
import com.lab1.backend.entities.User;
import com.lab1.backend.repository.FileHistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.InputStreamResource;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FileService {

    final UserService userService;

    final TransactionFileService transactionFileService;

    final MinioService minioService;

    final FileHistoryRepository fileHistoryRepository;

    public MessageResponse uploadFileManager(InputStream parsingFileStream, InputStream minioInputStream, String fileName, String contentType) {
        final var currentUser = userService.getCurrentUser();
        try {
            final var count = transactionFileService.uploadFile(parsingFileStream, minioInputStream, fileName, contentType);
            final var fileHistory = FileHistory.builder()
                    .fileName(fileName)
                    .user(currentUser)
                    .addedMoviesCount(count)
                    .status(FileHistory.Status.PASS)
                    .build();

            fileHistoryRepository.save(fileHistory);
            return new MessageResponse("Фильмы были успешно добавлены");
        } catch (Exception e) {
            e.printStackTrace();
            final var fileHistory = FileHistory.builder()
                    .fileName(fileName)
                    .user(currentUser)
                    .addedMoviesCount(0)
                    .status(FileHistory.Status.FAIL)
                    .build();

            fileHistoryRepository.save(fileHistory);
            return new MessageResponse("Фильмы не были добавлены");
        }
    }

    public List<FileHistoryRequest> getFileHistory() {
        final var currentUser = userService.getCurrentUser();
        List<FileHistory> fileHistoryList;
        if (currentUser.getRole() == User.Role.ROLE_ADMIN) {
            fileHistoryList = fileHistoryRepository.findAll();
        } else {
            fileHistoryList = fileHistoryRepository.findAllByUser(currentUser).orElse(new ArrayList<>());
        }

        return fileHistoryList.stream().map(FileHistory::toDto).toList();
    }

    public InputStreamResource getFileByName(String fileName) throws Exception {
        return new InputStreamResource(minioService.downloadFile(fileName));
    }

    public long getAvailable(String fileName) throws Exception {
        return minioService.downloadFile(fileName).available();
    }
}
