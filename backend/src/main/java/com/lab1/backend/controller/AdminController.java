package com.lab1.backend.controller;

import com.lab1.backend.dto.WaitingAdminUsernamesResponse;
import com.lab1.backend.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
@Tag(name = "Управление пользователями", description = "Методы управления пользователями")
public class AdminController {

    private final UserService userService;

    @Operation(summary = "Ждут получения админки")
    @GetMapping("/waiting-admin-list")
    public WaitingAdminUsernamesResponse getWaitingAdminUsers() {
        var usernames = userService.getWaitingAdminUsernames();
        return new WaitingAdminUsernamesResponse(usernames);
    }

    @GetMapping("/hello")
    public String hello() {
        return "Hello world!";
    }
}
