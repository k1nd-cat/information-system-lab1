package com.lab1.backend.controller;

import com.lab1.backend.dto.MovieDto;
import com.lab1.backend.dto.MoviesPageRequest;
import com.lab1.backend.dto.MoviesPageResponse;
import com.lab1.backend.service.MovieService;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.Data;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @PostMapping("/movies-page")
    public MoviesPageResponse getMoviesPage(@RequestBody MoviesPageRequest request) {
        return service.getMoviesPage(request);
    }

    @Deprecated
    @GetMapping("/get")
    public List<MovieDto> get(@RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "10") int size) {
        return service.getMovies(page, size);
    }

    @Deprecated
    @GetMapping("/count")
    public Map<String, Long> getMoviesCount() {
        return service.getMoviesCount();
    }

    // Обработка ошибок валидации
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getFieldErrors().forEach(error ->
                errors.put(error.getField(), error.getDefaultMessage())
        );
        return errors;
    }

}
