package com.lab1.backend.utils;

import com.lab1.backend.service.JwtService;
import lombok.AllArgsConstructor;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.DefaultHandshakeHandler;

import java.security.Principal;
import java.util.Map;

@AllArgsConstructor
public class JwtHandshakeHandler extends DefaultHandshakeHandler {

    private final JwtService jwtService;

    @Override
    protected Principal determineUser(ServerHttpRequest request, WebSocketHandler wsHandler, Map<String, Object> attributes) {
        // Извлекаем JWT
        var token = request.getURI().getQuery().split("token=")[1];
        if (token != null) {
            var username = jwtService.extractUserName(token);
            return new WebSocketUser(username);
        }
        return null; // Отклоняем соединение, если JWT недействителен
    }

    private static class WebSocketUser implements Principal {
        private final String name;

        public WebSocketUser(String name) {
            this.name = name;
        }

        @Override
        public String getName() {
            return name;
        }
    }
}