package com.lab1.backend.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        // Конфигурация брокера сообщений
        config.enableSimpleBroker("/queue", "/topic"); // Темы для подписки
        config.setApplicationDestinationPrefixes("/app"); // Префикс для отправки сообщений
        config.setUserDestinationPrefix("/user"); // Префикс для отправки персональных сообщений
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws") // Эндпоинт для WebSocket
                .setAllowedOriginPatterns(""); // Разрешенные домены
//                .withSockJS(); // Включаем поддержку SockJS для старых браузеров
    }
}