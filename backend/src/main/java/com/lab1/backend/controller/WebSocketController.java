package com.lab1.backend.controller;

import com.lab1.backend.dto.WaitingAdminStatusResponse;
import lombok.Data;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
@Data
public class WebSocketController {

    private final SimpMessagingTemplate messagingTemplate;

    public WebSocketController(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    public void sendWaitingAdminStatusToUser(String username, WaitingAdminStatusResponse message) {
        // Отправка персонального сообщения
        messagingTemplate.convertAndSendToUser(username, "/queue/updates", message);
    }
}