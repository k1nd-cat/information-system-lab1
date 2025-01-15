package com.lab1.backend.service;

import com.lab1.backend.dto.*;
import com.lab1.backend.entities.Person;
import com.lab1.backend.entities.Updates;
import com.lab1.backend.entities.User;
import com.lab1.backend.entities.Movie;
import com.lab1.backend.repository.MovieRepository;
import com.lab1.backend.repository.PersonRepository;
import com.lab1.backend.repository.UpdatesRepository;
import lombok.Data;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.*;

@Data
@Service
public class MovieService {

    private final MovieRepository repository;

    private final UpdatesRepository updatesRepository;

    private final UserService userService;

    private final PersonService personService;

    private final WebSocketService webSocketService;
    private final PersonRepository personRepository;

    public void createMovie(MovieDto request) {
        final var user = userService.getCurrentUser();
        final var movie = Movie.fromDto(request, user);
        safetyUpdatePersons(request, movie);
        if (movie.getLength() > 200) throw new RuntimeException("Длина фильма не может быть больше 200");
        repository.save(movie);

        webSocketService.sendChangedMoviesNotification("Фильм обновлён");
    }

    public void updateMovie(MovieDto request) {
        final var user = userService.getCurrentUser();
        final var movieFromDb = repository.findMovieById(request.getId())
                .orElseThrow(() -> new RuntimeException("Такого фильма не существует"));
        if (!(Objects.equals(movieFromDb.getUser().getUsername(), user.getUsername()) || (user.getRole() == User.Role.ROLE_ADMIN && movieFromDb.isModifiable()))) {
            throw new RuntimeException("Текущий пользователь не может изменять этот фильм");
        }
        final var movie = Movie.fromDto(request, movieFromDb);
        safetyUpdatePersons(request, movie);
        if (movie.getLength() > 200) throw new RuntimeException("Длина фильма не может быть больше 200");
        repository.save(movie);
        var updates = Updates.builder()
                    .user(user)
                    .movie(movie)
                    .updateDate(new Date())
        .build();
        updatesRepository.save(updates);

        webSocketService.sendChangedMoviesNotification("Фильм изменён");
    }

    public void deleteMovie(MovieDto request) {
        if (request.getId() == null) throw new RuntimeException("Невозможно идентифицировать фильм для удаления");
        final var movie = repository.findMovieById(request.getId())
                .orElseThrow(() -> new RuntimeException("Невозиожно найти фильм для удаления"));

        boolean canDeleteDirector = repository.countMoviesWithPerson(movie.getDirector().getPassportID()) == 1;
        boolean canDeleteScreenwriter = movie.getScreenwriter() == null || repository.countMoviesWithPerson(movie.getScreenwriter().getPassportID()) == 1;
        boolean canDeleteOperator = repository.countMoviesWithPerson(movie.getOperator().getPassportID()) == 0;

        final var creator = movie.getUser();
        final var user = userService.getCurrentUser();
        if (!(user.getRole() == User.Role.ROLE_ADMIN || Objects.equals(user.getUsername(), creator.getUsername()))) {
            throw new RuntimeException("Текущий пользователь не может удалять этот фильм");
        }
        updatesRepository.deleteAllByMovie(movie);

        repository.delete(movie);

        if (canDeleteDirector) {
            personService.deletePerson(movie.getDirector().getPassportID());
        }
        if (canDeleteScreenwriter && movie.getScreenwriter() != null) {
            personService.deletePerson(movie.getScreenwriter().getPassportID());
        }
        if (canDeleteOperator) {
            personService.deletePerson(movie.getOperator().getPassportID());
        }

        webSocketService.sendChangedMoviesNotification("Фильм удалён");
    }

    private void safetyUpdatePersons(MovieDto movieDto, Movie movie) {
        final var director = safetyUpdatePerson(movieDto.getDirector());
        final var screenwriter = movieDto.getScreenwriter() != null
                ? safetyUpdatePerson(movieDto.getScreenwriter())
                : null;
        final var operator = safetyUpdatePerson(movieDto.getOperator());
        movie.setDirector(director);
        movie.setScreenwriter(screenwriter);
        movie.setOperator(operator);
    }

    private Person safetyUpdatePerson(PersonDto personDto) {
        var personFromDb = personRepository.findByPassportID(personDto.getPassportID());
        Person person;
        if (personFromDb == null) {
            person = personService.createPerson(personDto);
        } else {
            try {
                person = personService.updatePerson(personDto);
            } catch (Exception e) {
                person = personFromDb;
            }
        }

        return person;
    }

    public MoviesPageResponse getMoviesPage(MoviesPageRequest request) {
        if (
                request.getNamePrefix() == null
                || request.getMinGoldenPalmCount() == null
                || request.getIsUsaBoxOfficeUnique() == null
        )
            throw new IllegalArgumentException("Значения полей для фильтрации должны быть объявлены");

        List<Movie> moviesByPrefix = repository.findByPrefixName(request.getNamePrefix());
        List<Movie> moviesByGoldenPalmCount = repository.findByMinGoldenPalmCount(request.getMinGoldenPalmCount());
        List<Movie> moviesByUniqueUsaBoxOffice = request.getIsUsaBoxOfficeUnique() ? repository.findByUniqueUsaBoxOffice() : null;

        moviesByPrefix.retainAll(moviesByGoldenPalmCount);
        if (moviesByUniqueUsaBoxOffice != null) {
            moviesByPrefix.retainAll(moviesByUniqueUsaBoxOffice);
        }

        var movies = moviesByPrefix;
        int fromIndex = (request.getPage() - 1) * request.getSize();
        int toIndex = Math.min(fromIndex + request.getSize(), movies.size());
        var pageCount = (int) Math.ceil((double) movies.size() / request.getSize());
        movies = movies.subList(fromIndex, toIndex);
        if (request.getSorting() == MoviesPageRequest.Sorting.alphabetically) {
            movies.sort(Comparator.comparing(Movie::getName));
        } else if (request.getSorting() == MoviesPageRequest.Sorting.other) {
            movies.sort(Comparator.comparing(Movie::getName).reversed());
        }
        var movieDtos = movies.stream().map(Movie::toDto).toList();

        if (fromIndex > toIndex) {
            throw new IllegalArgumentException("Текущей страницы не существует");
        }


        return MoviesPageResponse.builder()
                .pageCount(pageCount)
                .movies(movieDtos)
                .build();
    }

    @Deprecated
    public List<MovieDto> getMovies(int page, int size) {
        final Pageable pageable = PageRequest.of(page, size);
        final var movies = repository.findAll(pageable);
        return movies.getContent().stream()
                .map(Movie::toDto).toList();
    }

    @Deprecated
    public Map<String, Long> getMoviesCount() {
        final var count = repository.count();
        final var response = new HashMap<String, Long>();
        response.put("count", count);
        return response;
    }

    public List<Person> getWithZeroOscarCount() {
        return personRepository.getWithZeroOscarCount();
    }

    public MovieDto getById(Long id) {
        var movie = repository.findMovieById(id)
                .orElseThrow(() -> new IllegalArgumentException("Невозможно найти Фильм по заданному id"));
        return movie.toDto();
    }

    public MessageResponse addOscars(Integer addOscarsCount) {
        final var user = userService.getCurrentUser();
        List<Movie> movies = repository.updateOscarCount(user.getUsername(), addOscarsCount);
        Date updateDate = new Date();
        for (var movie : movies) {
            var updates = Updates.builder()
                    .user(user)
                    .movie(movie)
                    .updateDate(updateDate)
                    .build();
            updatesRepository.save(updates);
        }

        webSocketService.sendChangedMoviesNotification("Добавлены оскары");
        return new MessageResponse("Фильмам добавлено " + addOscarsCount + " оскаров");
    }

    public MessageResponse deletePerson(PersonDto dto) {
//        final var passportId = dto.getPassportID();
        final var person = personRepository.findById(dto.getPassportID()).orElseThrow(
                () -> new IllegalArgumentException("Персонаж с заданным passport id не найден"));
        final var user = userService.getCurrentUser();
        final var creator = person.getUser();
        if (!(user.getRole() == User.Role.ROLE_ADMIN || Objects.equals(user.getUsername(), creator.getUsername()))) {
            throw new AccessDeniedException("Пользователь с заданными правами не может удалить данного персонажа");
        }

        final var movies = repository.findAll();
        for (var movie : movies) {
            if (
                    Objects.equals(movie.getOperator().getPassportID(), person.getPassportID())
                    || (movie.getScreenwriter() != null && Objects.equals(movie.getScreenwriter().getPassportID(), person.getPassportID()))
                    || Objects.equals(movie.getDirector().getPassportID(), person.getPassportID())
            ) {
                updatesRepository.deleteAllByMovie(movie);
                repository.delete(movie);
                if (repository.countMoviesWithPerson(movie.getDirector().getPassportID()) == 0) {
                    try {
                        personService.deletePerson(movie.getDirector().getPassportID());
                    } catch (Exception ignore) {}
                }
                if (movie.getScreenwriter() != null && repository.countMoviesWithPerson(movie.getScreenwriter().getPassportID()) == 0) {
                    try {
                    personService.deletePerson(movie.getScreenwriter().getPassportID());
                    } catch (Exception ignore) {}
                }
                if (repository.countMoviesWithPerson(movie.getOperator().getPassportID()) == 0) {
                    try {
                    personService.deletePerson(movie.getOperator().getPassportID());
                    } catch (Exception ignore) {}
                }
//                deleteMovie(movie.toDto());
            }
        }
//        personRepository.delete(person);
        webSocketService.sendChangedMoviesNotification("Фильм изменён");

        return new MessageResponse("Персонаж успешно удалён");
    }
}
