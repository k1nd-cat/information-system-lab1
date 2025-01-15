package com.lab1.backend.entities;

import com.lab1.backend.dto.FileHistoryRequest;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "file_history")
public class FileHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Status status;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "file_name", nullable = false)
    String fileName;

    @Column(name = "count")
    private Integer addedMoviesCount;

    public enum Status {
        PASS,
        FAIL
    }

    public FileHistoryRequest toDto() {
        return FileHistoryRequest.builder()
                .id(this.id)
                .status(this.status)
                .creatorName(this.user.getUsername())
                .fileName(this.fileName)
                .addedMoviesCount(this.addedMoviesCount)
                .build();
    }
}
