package com.lab1.lab1.controller.user;

import com.lab1.lab1.service.user.UserAuthenticationService;
import com.lab1.lab1.service.user.UserStatusService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/status")
@AllArgsConstructor
public class UserStatusController {

    private final UserStatusService service;

    @GetMapping("/waiting-approve")
    public Object waitingApprove(@RequestHeader String token) {
        return service.waitingApprove(token);
    }
}
