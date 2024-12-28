package com.lab1.backend.controller;

import com.lab1.backend.dto.MessageResponse;
import com.lab1.backend.dto.PersonDto;
import com.lab1.backend.service.MovieService;
import com.lab1.backend.service.PersonService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/person")
@AllArgsConstructor
@Data
@Tag(name = "Запросы связанные с сущностью `Person`", description = "Методы для выполнения запросов, связанных с `Person`")
public class PersonController {

    private final PersonService service;

    private final MovieService movieService;
    private final PersonService personService;

    @GetMapping("/get-all")
    @Operation(summary = "Получить список всех `Person")
    public List<PersonDto> getAllPersons() {
        return service.getAll();
    }

    @GetMapping("/with-zero-oscar-count")
    @Operation(summary = "Получить список операторов, ильмы которых не получили ни одного оскара")
    public List<PersonDto> getWithZeroOscarCount() {
        return service.getWithZeroOscarCount();
    }

    @PostMapping("/delete")
    @Operation(summary = "Удалить персонажа")
    public MessageResponse deletePerson(@RequestBody PersonDto dto) {
        return movieService.deletePerson(dto);
    }

    @PostMapping("/update")
    @Operation(summary = "Обновить персонажа")
    public MessageResponse updatePerson(@RequestBody PersonDto dto) {
        return personService.updatePersonResponse(dto);
    }
}
