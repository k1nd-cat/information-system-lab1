package com.lab1.backend.service;

import com.lab1.backend.dto.UpdatedRoleResponse;
import lombok.Data;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

@Data
@Service
public class WebSocketService {

    private final SimpMessagingTemplate messagingTemplate;

    public void sendUpdatedRoleForUser(String username, UpdatedRoleResponse message) {
        messagingTemplate.convertAndSendToUser(username, "/queue/private", message);
    }
}
