package com.lab1.lab1.dto.user.authentication;

import lombok.Data;

@Data
public class UserLoginRequest {
    private String login;
    private String password;
    private Boolean isAdmin;
}
