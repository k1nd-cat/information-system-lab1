package com.lab1.lab1.controller;

import com.lab1.lab1.utils.Secutiry;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class HelloWorldController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello World";
    }

    @GetMapping("/password")
    public String password() {
        var password = "Hello, World!";
        var passwordEncoder = new Secutiry();
        var hash = passwordEncoder.getMd5Hash(password);
        return hash + " | " + passwordEncoder.verifyPassword(password, hash) + " | " + passwordEncoder.verifyPassword("password", hash);
    }
}
