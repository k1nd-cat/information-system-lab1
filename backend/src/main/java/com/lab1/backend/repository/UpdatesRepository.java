package com.lab1.backend.repository;

import com.lab1.backend.entities.Movie;
import com.lab1.backend.entities.Updates;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.Modifying;

@Repository
public interface UpdatesRepository extends JpaRepository<Updates, Long> {

    @Modifying
    @Transactional
    void deleteAllByMovie(Movie movie);
}