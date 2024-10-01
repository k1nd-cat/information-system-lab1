package com.lab1.lab1.dto.user.authentication.response;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserLoginResponse {
    private String login;
    private String token;
    private Boolean isAdminApproved;
}
