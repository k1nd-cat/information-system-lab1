package com.lab1.backend.service;

import com.lab1.backend.dto.MovieRequest;
import com.lab1.backend.entities.Person;
import com.lab1.backend.entities.User;
import com.lab1.backend.entities.Movie;
import com.lab1.backend.repository.MovieRepository;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Data
@Service
public class MovieService {

    private final MovieRepository movieRepository;

    private final UserService userService;

    private final PersonService personService;

    public void createMovie(MovieRequest request) {
        final var user = userService.getCurrentUser();
        final var movie = Movie.fromDto(request, user);
        safetyUpdatePerson(movie);
        movieRepository.save(movie);
        // TODO: Добавить websocket
    }

    public void updateMovie(MovieRequest request) {
        final var user = userService.getCurrentUser();
        if (!(Objects.equals(user.getUsername(), request.getCreatorName()) || user.getRole() == User.Role.ROLE_ADMIN && request.getIsEditable())) {
            throw new RuntimeException("Текущий пользователь не может изменять этот фильм");
        }

        final var movieFromDb = movieRepository.findMovieById(request.getId())
                .orElseThrow(() -> new RuntimeException("Такого фильма не существует"));
        final var movie = Movie.fromDto(request, movieFromDb);
        safetyUpdatePerson(movie);
        movieRepository.save(movie);
        // TODO: Добавить websocket
    }

    public void deleteMovie(MovieRequest request) {
        if (request.getId() == null) throw new RuntimeException("Невозможно идентифицировать фильм для удаления");
        final var movie = movieRepository.findMovieById(request.getId())
                .orElseThrow(() -> new RuntimeException("Невозиожно найти фильм для удаления"));
        final var creator = movie.getUser();
        final var user = userService.getCurrentUser();
        if (!(user.getRole() == User.Role.ROLE_ADMIN || Objects.equals(user.getUsername(), creator.getUsername()))) {
            throw new RuntimeException("Текущий пользователь не может удалять этот фильм");
        }

        movieRepository.delete(movie);
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
}
