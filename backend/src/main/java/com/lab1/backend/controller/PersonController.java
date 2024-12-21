package com.lab1.backend.controller;

import com.lab1.backend.entities.Person;
import com.lab1.backend.service.PersonService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/person")
@AllArgsConstructor
@Data
@Tag(name = "Запросы связанные с сущностью `Person`", description = "Методы для выполнения запросов, связанных с `Person`")
public class PersonController {

    private final PersonService service;

    @GetMapping("/get-all")
    @Operation(summary = "Получить список всех `Person")
    public List<Person> getAllPersons() {
        return service.getAll();
    }
}
