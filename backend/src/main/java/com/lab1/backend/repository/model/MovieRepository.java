package com.lab1.backend.repository.model;

import com.lab1.backend.entity.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MovieRepository extends JpaRepository<Movie, Long> {
    Optional<Movie> findMovieById(long id);
}
