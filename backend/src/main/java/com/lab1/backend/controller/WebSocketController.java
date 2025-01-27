package com.lab1.backend.controller;

import com.lab1.backend.dto.UpdatedRoleResponse;
import lombok.Data;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
@Data
public class WebSocketController {

    private final SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/private/{username}")
    public void sendUpdatedRoleForUser(@Payload UpdatedRoleResponse message, @org.springframework.messaging.handler.annotation.DestinationVariable String username) {
        messagingTemplate.convertAndSendToUser(username, "/queue/private", message);
    }

    @MessageMapping("/broadcast")
    @SendTo("/topic/broadcast")
    public String sendChangedMoviesNotification(@Payload String message) {
        return message;
    }
}