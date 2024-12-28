package com.lab1.backend.controller;

import com.lab1.backend.dto.*;
import com.lab1.backend.service.MovieService;
import io.swagger.v3.oas.annotations.Operation;
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
    @Operation(summary = "Создать фильм")
    public void create(@RequestBody @Valid MovieDto request) {
        service.createMovie(request);
    }

    @PostMapping("/update")
    @Operation(summary = "Обновить фильм")
    public void update(@RequestBody @Valid MovieDto request) {
        service.updateMovie(request);
    }

    @PostMapping("/delete")
    @Operation(summary = "Удалить фильм")
    public void delete(@RequestBody @Valid MovieDto request) {
        service.deleteMovie(request);
    }

    @PostMapping("/movies-page")
    @Operation(summary = "Получить страницу с фильмами")
    public MoviesPageResponse getMoviesPage(@RequestBody MoviesPageRequest request) {
        return service.getMoviesPage(request);
    }

    @Deprecated
    @GetMapping("/get")
    @Operation(summary = "Получить фильм")
    public List<MovieDto> get(@RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "10") int size) {
        return service.getMovies(page, size);
    }

    @Deprecated
    @GetMapping("/count")
    @Operation(summary = "Получить количество фильмов")
    public Map<String, Long> getMoviesCount() {
        return service.getMoviesCount();
    }

    @PostMapping("/get-by-id")
    @Operation(summary = "Получить фильм по id")
    public MovieDto getById(@RequestBody FindByIdRequest request) {
        return service.getById(request.getId());
    }

    @PostMapping("/add-oscar")
    @Operation(summary = "Добавить фильмам заданное число оскаров")
    public MessageResponse addOscars(@RequestBody AddOscarsRequest request) {
        return service.addOscars(request.getValue());
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
