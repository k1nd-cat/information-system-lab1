package com.lab1.backend.service;

import com.lab1.backend.dto.AuthenticationResponse;
import com.lab1.backend.dto.CheckTokenRequest;
import com.lab1.backend.dto.SignInRequest;
import com.lab1.backend.dto.SignUpRequest;
import com.lab1.backend.entities.User;
import lombok.Data;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Data
@Service
public class AuthenticationService {

    private final UserService userService;
    private final JwtService jwtService;
    private final PasswordEncoder passwordEncoder;
    public final AuthenticationManager authenticationManager;

    public AuthenticationResponse signUp(SignUpRequest request) {
        // Проверка на существование пользователя с таким именем
        if (userService.isUsernameExists(request.getUsername())) {
            throw new RuntimeException("Пользователь с таким именем уже существует");
        }

        // Создание нового пользователя
        var user = User.builder()
                .username(request.getUsername())
                .password(passwordEncoder.encode(request.getPassword()))
                .isWaitingAdmin(request.getIsWaitingAdmin())
                .build();

        // Если пользователь запрашивает роль администратора, но администратор отсутствует
        if (user.getIsWaitingAdmin() && !userService.isAdminExists()) {
            user.setRole(User.Role.ROLE_ADMIN);
            user.setIsWaitingAdmin(false); // Уже назначили роль администратора
        } else {
            user.setRole(User.Role.ROLE_USER);
        }

        // Сохранение пользователя
        user = userService.create(user);

        // Генерация JWT токена для нового пользователя
        var jwt = jwtService.generateToken(user);

        return new AuthenticationResponse(jwt, user.getRole(), user.getIsWaitingAdmin(), user.getUsername());
    }

    public AuthenticationResponse signIn(SignInRequest request) {
        try {
            // Проверка аутентификационных данных
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword())
            );
        } catch (BadCredentialsException e) {
            throw new BadCredentialsException("Неверный логин или пароль", e);
        }

        // Загрузка пользователя после успешной аутентификации
        var user = userService.userDetailsService().loadUserByUsername(request.getUsername());
        var userFromDb = userService.getByUsername(request.getUsername());

        var jwt = jwtService.generateToken(user);

        return new AuthenticationResponse(jwt, userFromDb.getRole(), userFromDb.getIsWaitingAdmin(), user.getUsername());
    }

    public AuthenticationResponse checkToken(CheckTokenRequest request) {
        var token = request.getToken();
        try {
            var username = jwtService.extractUserName(token);
            var user = userService.getByUsername(username);
            return new AuthenticationResponse(token, user.getRole(), user.getIsWaitingAdmin(), user.getUsername());
        } catch (Exception e) {
            throw new IllegalArgumentException("Неверный токен");
        }
    }
}
