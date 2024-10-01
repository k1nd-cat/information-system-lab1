package com.lab1.lab1.dto.user.authentication.request;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserLogoutRequest {
    private String token;
}
