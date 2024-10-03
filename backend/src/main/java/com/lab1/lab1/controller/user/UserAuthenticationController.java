package com.lab1.lab1.controller.user;

import com.lab1.lab1.dto.user.authentication.request.UserLoginRequest;
import com.lab1.lab1.dto.user.authentication.request.UserLogoutRequest;
import com.lab1.lab1.service.user.AuthenticationService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/authentication")
@AllArgsConstructor
public class UserAuthenticationController {

    private final AuthenticationService service;

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody UserLoginRequest request) {
        return service.login(request);
    }

    @PostMapping("/register")
    public Map<String, Object> register(@RequestBody UserLoginRequest request) {
        return service.register(request);
    }

    @PostMapping("/logout")
    public void logout(@RequestBody UserLogoutRequest request) {
        service.logout(request);
    }
}
