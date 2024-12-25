package com.lab1.backend.controller;

import com.lab1.backend.dto.ApproveRejectAdminRequest;
import com.lab1.backend.dto.ErrorResponse;
import com.lab1.backend.dto.MessageResponse;
import com.lab1.backend.entities.User;
import com.lab1.backend.service.AdminService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.nio.file.AccessDeniedException;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
@Tag(name = "Управление пользователями", description = "Методы управления пользователями")
public class AdminController {

    private final AdminService service;

    @GetMapping("/waiting-admin-list")
    @Operation(summary = "Список username пользователей, которые хотят стать администраторами")
    public List<String> getWaitingAdminUsers() throws AccessDeniedException {
        return service.getWaitingAdminUsernames();
    }

    @PostMapping("/approve-admin")
    @Operation(summary = "Одобрить роль администратора пользователю с заданным username")
    public MessageResponse approveAdmin(@RequestBody @Valid ApproveRejectAdminRequest request) throws AccessDeniedException {
        return service.setUserRole(request.getUsername(), User.Role.ROLE_ADMIN);
    }

    @PostMapping("/reject-admin")
    @Operation(summary = "Отклонить роль администратора пользователю с заданным username")
    public MessageResponse rejectAdmin(@RequestBody @Valid ApproveRejectAdminRequest request) throws AccessDeniedException {
        return service.setUserRole(request.getUsername(), User.Role.ROLE_USER);
    }

    @ExceptionHandler(AccessDeniedException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public ErrorResponse error(AccessDeniedException e) {
        return new ErrorResponse(e.getMessage());
    }

    @ExceptionHandler(DataIntegrityViolationException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public ErrorResponse error(DataIntegrityViolationException e) {
        return new ErrorResponse(e.getMessage());
    }

    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public ErrorResponse error(RuntimeException e) {
        return new ErrorResponse("Не удалось выполнить запрос");
    }
}
