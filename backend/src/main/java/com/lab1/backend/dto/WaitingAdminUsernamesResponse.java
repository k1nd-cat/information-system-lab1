package com.lab1.backend.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "Список username пользователей, которые хотят получить админку")
public class WaitingAdminUsernamesResponse {
    @Schema(description = "Список всех пользователей, у которых значение параметра isWaitingAdmin == true")
    List<String> usernames;
}
