package com.lab1.backend.service;

import com.lab1.backend.dto.MovieDto;
import com.lab1.backend.entities.User;
import com.lab1.backend.entities.Movie;
import com.lab1.backend.repository.MovieRepository;
import lombok.Data;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Data
@Service
public class MovieService {

    private final MovieRepository repository;

    private final UserService userService;

    private final PersonService personService;

    public void createMovie(MovieDto request) {
        final var user = userService.getCurrentUser();
        final var movie = Movie.fromDto(request, user);
        safetyUpdatePerson(movie);
        repository.save(movie);
        // TODO: Добавить websocket
    }

    public void updateMovie(MovieDto request) {
        final var user = userService.getCurrentUser();
        if (!(Objects.equals(user.getUsername(), request.getCreatorName()) || user.getRole() == User.Role.ROLE_ADMIN && request.getIsEditable())) {
            throw new RuntimeException("Текущий пользователь не может изменять этот фильм");
        }

        final var movieFromDb = repository.findMovieById(request.getId())
                .orElseThrow(() -> new RuntimeException("Такого фильма не существует"));
        final var movie = Movie.fromDto(request, movieFromDb);
        safetyUpdatePerson(movie);
        repository.save(movie);
        // TODO: Добавить websocket
    }

    public void deleteMovie(MovieDto request) {
        if (request.getId() == null) throw new RuntimeException("Невозможно идентифицировать фильм для удаления");
        final var movie = repository.findMovieById(request.getId())
                .orElseThrow(() -> new RuntimeException("Невозиожно найти фильм для удаления"));
        final var creator = movie.getUser();
        final var user = userService.getCurrentUser();
        if (!(user.getRole() == User.Role.ROLE_ADMIN || Objects.equals(user.getUsername(), creator.getUsername()))) {
            throw new RuntimeException("Текущий пользователь не может удалять этот фильм");
        }

        repository.delete(movie);
        // TODO: Добавить websocket
    }

    private void safetyUpdatePerson(Movie movie) {
        final var director = personService.save(movie.getDirector());
        final var screenwriter = movie.getScreenwriter() != null
                ? personService.save(movie.getScreenwriter())
                : null;
        final var operator = personService.save(movie.getOperator());

        movie.setDirector(director);
        movie.setScreenwriter(screenwriter);
        movie.setOperator(operator);
    }

    public List<MovieDto> getMovies(int page, int size) {
        final Pageable pageable = PageRequest.of(page, size);
        final var movies = repository.findAll(pageable);
        return movies.getContent().stream()
                .map(Movie::toDto).toList();

    }
}
