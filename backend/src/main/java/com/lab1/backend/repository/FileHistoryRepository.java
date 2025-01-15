package com.lab1.backend.repository;

import com.lab1.backend.entities.FileHistory;
import com.lab1.backend.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FileHistoryRepository  extends JpaRepository<FileHistory, Long> {
    Optional<List<FileHistory>> findAllByUser(User user);
}
