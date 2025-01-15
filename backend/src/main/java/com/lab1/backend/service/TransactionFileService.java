package com.lab1.backend.service;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;

@Service
@RequiredArgsConstructor
public class TransactionFileService {

    final FileParserService fileParserService;

    final MovieService movieService;

    final MinioService minioService;

    @Transactional(rollbackFor = {Exception.class, Error.class}, isolation = Isolation.SERIALIZABLE)
    public Integer uploadFile(InputStream parsingFileStream, InputStream minioInputStream, String fileName, String contentType) throws Exception {
        final var moviesDto = fileParserService.parseFile(parsingFileStream, fileName);
        moviesDto.forEach(movieService::createMovie);

        minioService.uploadFile(fileName, minioInputStream, minioInputStream.available(), contentType);

        return moviesDto.size();
    }
}
