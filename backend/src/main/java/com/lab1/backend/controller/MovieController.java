package com.lab1.backend.controller;

import com.lab1.backend.dto.MovieDto;
import com.lab1.backend.service.MovieService;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.Data;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Data
@RequestMapping("/movie")
@Tag(name = "Обработка фильмов", description = "Методы для создания, обновления, удаления фильмов")
public class MovieController {

    private final MovieService service;

    @PostMapping("/create")
    public void create(@RequestBody @Valid MovieDto request) {
        service.createMovie(request);
    }

    @PostMapping("/update")
    public void update(@RequestBody @Valid MovieDto request) {
        service.updateMovie(request);
    }

    @PostMapping("/delete")
    public void delete(@RequestBody @Valid MovieDto request) {
        service.deleteMovie(request);
    }

    @GetMapping("/get")
    public List<MovieDto> get(@RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "10") int size) {
        return service.getMovies(page, size);
    }
}
