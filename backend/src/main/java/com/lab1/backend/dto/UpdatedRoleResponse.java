package com.lab1.backend.dto;

import com.lab1.backend.entities.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UpdatedRoleResponse {
    private User.Role role;
    private Boolean isWaitingAdmin;
    private String token;
}
