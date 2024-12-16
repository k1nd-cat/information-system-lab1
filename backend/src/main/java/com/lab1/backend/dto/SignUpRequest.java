package com.lab1.backend.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
@Schema(description = "Запрос на регистрацию")
public class SignUpRequest {

    @Schema(description = "Имя пользователя", example = "k1nd-cat")
    @Size(min = 4, max = 50, message = "Имя пользователя может содержать от 4 до 50 символов")
    @NotBlank(message = "Имя пользователя не может быть пустым")
    private String username;

    @Schema(description = "Пароль", example = "my_password")
    @Size(min = 8, max = 255, message = "Пароль может содержать от 8 до 255 символов")
    @NotBlank(message = "Пароль не может быть пустым")
    private String password;

    @Schema(description = "Был ли запрос на должность администратора", example = "false")
    @NotNull
    private Boolean isWaitingAdmin;
}
