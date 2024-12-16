package com.lab1.backend.controller;

import com.lab1.backend.dto.ApproveRejectAdminRequest;
import com.lab1.backend.dto.ErrorDto;
import com.lab1.backend.dto.WaitingAdminUsernamesResponse;
import com.lab1.backend.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
@AllArgsConstructor
@Data
@Tag(name = "Пользовательские запросы", description = "Методы для выполнения запросов, связанных с пользователем")
public class UserController {

    private UserService service;

    @GetMapping("/request-admin")
    @Operation(summary = "Запросить админку, если пользователь не администратор")
    public void setWaitingAdmin() {
        service.setWaitingAdmin();
    }

    @Operation(summary = "Ждут получения админки")
    @GetMapping("/waiting-admin")
    public WaitingAdminUsernamesResponse getWaitingAdminUsers() {
        var usernames = service.getWaitingAdminUsernames();
        return new WaitingAdminUsernamesResponse(usernames);
    }

    @Operation(summary = "Сделать пользователя администратором")
    @PostMapping("approve-admin")
    public void approveAdmin(@RequestBody @Valid ApproveRejectAdminRequest request) {
        service.approveAdmin(request.getUsername());
    }

    @Operation(summary = "Отклонить запрос пользователя на роль администратора")
    @PostMapping("reject-admin")
    public void rejectAdmin(@RequestBody @Valid ApproveRejectAdminRequest request) {
        service.rejectAdmin(request.getUsername());
    }

    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorDto error(Exception e) {
        return new ErrorDto(e.getMessage());
    }
}
