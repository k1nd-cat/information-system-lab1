package com.lab1.backend.controller;

import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hello")
@AllArgsConstructor
@Data
public class HelloWorldController {

    @Operation(summary = "Hello world GET Mapping")
    @GetMapping(value = "/world", produces = "application/json")
    public String hello() {
        return "Hello World";
    }
}
