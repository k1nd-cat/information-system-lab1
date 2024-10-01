package com.lab1.lab1.controller.user;

import com.lab1.lab1.dto.user.authentication.request.UserLoginRequest;
import com.lab1.lab1.dto.user.authentication.request.UserLogoutRequest;
import com.lab1.lab1.dto.user.authentication.response.UserLoginResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/authentication")
public class UserAuthenticationController {

    @PostMapping("/login")
    public ResponseEntity<UserLoginResponse> login(@RequestBody UserLoginRequest request) {
        var response = new UserLoginResponse("login", "token", null);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/register")
    public ResponseEntity<UserLoginResponse> register(@RequestBody UserLoginRequest request) {
        var response = new UserLoginResponse("login", "token", null);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestBody UserLogoutRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }
}
