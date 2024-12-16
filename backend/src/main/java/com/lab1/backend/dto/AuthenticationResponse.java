package com.lab1.backend.dto;

import com.lab1.backend.entities.User;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "Ответ с токеном доступа")
public class AuthenticationResponse {

    @Schema(description = "JWT токен доступа", example = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTYyMjUwNj...")
    private String token;

    @Schema(description = "Роль пользователя", example = "Role.USER")
    private User.Role role;

    @Schema(description = "isWaitingAdmin", example = "true")
    private Boolean isWaitingAdmin;

    @Schema(description = "Имя пользователя", example = "k1nd_cat")
    private String username;
}
