package com.lab1.lab1.controller.user;

import com.lab1.lab1.dto.user.authentication.UserLoginRequest;
import com.lab1.lab1.service.user.UserAuthenticationService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/authentication")
@AllArgsConstructor
public class UserAuthenticationController {

    private final UserAuthenticationService service;

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody UserLoginRequest request) {
        return service.login(request);
    }

    @PostMapping("/register")
    public Map<String, Object> register(@RequestBody UserLoginRequest request) {
        return service.register(request);
    }

    @GetMapping("/logout")
    public void logout(@RequestHeader String token) {
        service.logout(token);
    }
}
