package com.lab1.backend.controller;

import com.lab1.backend.dto.*;
import com.lab1.backend.service.AuthenticationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@Tag(name = "Аутентификация", description = "Методы для аутентификации через JWT токены")
public class AuthenticationController {
    private final AuthenticationService authenticationService;

    @Operation(summary = "Авторизация пользователя")
    @PostMapping("/sign-in")
    public AuthenticationResponse signIn(@RequestBody @Valid SignInRequest request) {
        return authenticationService.signIn(request);
    }

    @Operation(summary = "Регистрация пользователя")
    @PostMapping("/sign-up")
    public AuthenticationResponse signUp(@RequestBody @Valid SignUpRequest request) {
        return authenticationService.signUp(request);
    }

    @Operation(summary = "Проверка токена")
    @PostMapping("/check-token")
    public AuthenticationResponse checkToken(@RequestBody @Valid CheckTokenRequest request) {
        return authenticationService.checkToken(request);
    }

    // Обработка ошибок валидации
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getFieldErrors().forEach(error ->
                errors.put(error.getField(), error.getDefaultMessage())
        );
        return errors;
    }

    // Обработка ошибок аутентификации
    @ExceptionHandler(BadCredentialsException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public ErrorDto handleBadCredentials(BadCredentialsException ex) {
        return new ErrorDto("Неверный логин или пароль");
    }

    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorDto error(Exception e) {
        return new ErrorDto(e.getMessage());
    }
}
