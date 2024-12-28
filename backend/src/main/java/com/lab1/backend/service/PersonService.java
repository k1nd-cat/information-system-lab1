package com.lab1.backend.service;

import com.lab1.backend.dto.MessageResponse;
import com.lab1.backend.dto.PersonDto;
import com.lab1.backend.entities.Person;
import com.lab1.backend.entities.User;
import com.lab1.backend.repository.MovieRepository;
import com.lab1.backend.repository.PersonRepository;
import lombok.Data;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Data
@Service
public class PersonService {

    private final PersonRepository repository;

    private final MovieRepository movieRepository;

    private final UserService userService;

    private final WebSocketService webSocketService;

    public Person save(Person person) {
        return repository.save(person);
    }

    public List<PersonDto> getAll() {
        return repository.findAll().stream().map(Person::toDto).toList();
    }

    public void deletePerson(String id) {
        repository.deleteById(id);
    }

    public List<PersonDto> getWithZeroOscarCount() {
        return repository.getWithZeroOscarCount().stream().map(Person::toDto).toList();
    }

    public Person createPerson(PersonDto dto) {
        return save(Person.fromDto(dto, userService.getCurrentUser()));
    }

    @Deprecated
//    TODO: check method and do delete all movies witch include this person
    public MessageResponse deletePerson(PersonDto dto) {
        final var passportId = dto.getPassportID();
        final var person = repository.findById(passportId).orElseThrow(
                () -> new IllegalArgumentException("Персонаж с заданным passport id не найден"));
        final var user = userService.getCurrentUser();
        final var creator = person.getUser();
        if (!(user.getRole() == User.Role.ROLE_ADMIN || Objects.equals(user.getUsername(), creator.getUsername()))) {
            throw new AccessDeniedException("Пользователь с заданными правами не может удалить данного персонажа");
        }
        final var movies = movieRepository.findAll();
        for (var movie : movies) {
            if (movie.getOperator() == person || movie.getScreenwriter() == person || movie.getDirector() == person) {
                movieRepository.delete(movie);
            }
        }
        repository.delete(person);
//        repository.delete(person);
        webSocketService.sendChangedMoviesNotification("Фильм изменён");

        return new MessageResponse("Персонаж успешно удалён");
    }

    //    TODO: check method
    public MessageResponse updatePersonResponse(PersonDto dto) {
        updatePerson(dto);
        webSocketService.sendChangedMoviesNotification("Фильм изменён");

        return new MessageResponse("Персонаж успешно обновлён");
    }

    public Person updatePerson(PersonDto dto) {
        var passportId = dto.getPassportID();
        var personFromDb = repository.findById(passportId).orElseThrow(
                () -> new IllegalArgumentException("Персонаж с заданным passport id не найден"));
        final var user = userService.getCurrentUser();
        final var creator = personFromDb.getUser();
        if (!(Objects.equals(creator.getUsername(), user.getUsername()) || (user.getRole() == User.Role.ROLE_ADMIN && personFromDb.isModifiable()))) {
            throw new AccessDeniedException("Пользователь с заданными правами не может обновить данного персонажа");
        }

        personFromDb.setName(dto.getName());
        personFromDb.setModifiable(dto.getIsEditable());
        personFromDb.setLocation(dto.getLocation() != null ? Person.Location.fromDto(dto.getLocation()) : null);
        personFromDb.setNationality(dto.getNationality());
        personFromDb.setEyeColor(dto.getEyeColor());
        personFromDb.setHairColor(dto.getHairColor());

        return repository.save(personFromDb);
    }


}
