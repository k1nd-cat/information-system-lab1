package com.lab1.backend.dto;

import com.lab1.backend.entities.FileHistory;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FileHistoryRequest {
    private Long id;

    private FileHistory.Status status;

    private String creatorName;

    String fileName;

    private Integer addedMoviesCount;
}
