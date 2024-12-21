package com.lab1.backend.controller;

import com.lab1.backend.dto.MovieRequest;
import com.lab1.backend.service.MovieService;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.Data;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Data
@RequestMapping("/movie")
@Tag(name = "Обработка фильмов", description = "Методы для создания, обновления, удаления фильмов")
public class MovieController {

    private final MovieService movieService;

    @PostMapping("/create")
    public void create(@RequestBody @Valid MovieRequest request) {
        movieService.createMovie(request);
    }

    @PostMapping("/update")
    public void update(@RequestBody @Valid MovieRequest request) {
        movieService.updateMovie(request);
    }

    @PostMapping("/delete")
    public void delete(@RequestBody @Valid MovieRequest request) {
        movieService.deleteMovie(request);
    }
}
