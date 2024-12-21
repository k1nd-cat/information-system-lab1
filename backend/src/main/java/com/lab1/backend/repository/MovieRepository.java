package com.lab1.backend.repository;

import com.lab1.backend.entities.Movie;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.domain.Pageable;
import java.util.Optional;

public interface MovieRepository extends JpaRepository<Movie, Long> {
    Optional<Movie> findMovieById(long id);

    Page<Movie> findAll(Pageable pageable);
}
