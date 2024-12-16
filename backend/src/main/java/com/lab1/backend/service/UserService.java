package com.lab1.backend.service;

import com.lab1.backend.controller.WebSocketController;
import com.lab1.backend.entities.User;
import com.lab1.backend.repository.UserRepository;
import com.lab1.backend.dto.WaitingAdminStatusResponse;
import lombok.Data;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Data
public class UserService {

    private final UserRepository repository;

    private final WebSocketController webSocketController;

    public User save(User user) {
        return repository.save(user);
    }

    public User create(User user) {
        if (repository.existsByUsername(user.getUsername())) {
            throw new RuntimeException("Пользователь с таким именем уже существует");
        }


        return save(user);
    }

    public User getByUsername(String username) {
        return repository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь не найден"));
    }

    public UserDetailsService userDetailsService() {
        return this::getByUsername;
    }

    public User getCurrentUser() {
        var username = SecurityContextHolder.getContext()
                .getAuthentication().getName();

        return getByUsername(username);
    }

    public void approveAdmin(String username) {
        var currentUser = this.getCurrentUser();
        if (currentUser.getRole() != User.Role.ROLE_ADMIN) {
            throw new RuntimeException("Пользователь не имеет доступа к данному запросу");
        }

        var user = getByUsername(username);
        if (user.getRole() == User.Role.ROLE_ADMIN) {
            if (user.getIsWaitingAdmin()) user.setIsWaitingAdmin(false);
            save(user);
            throw new IllegalArgumentException("Пользователь уже является администратором");
        }

        user.setRole(User.Role.ROLE_ADMIN);
        user.setIsWaitingAdmin(false);
        save(user);

        var waitingAdminStatusResponse = new WaitingAdminStatusResponse(user.getRole(), user.getIsWaitingAdmin());

        webSocketController.sendWaitingAdminStatusToUser(username, waitingAdminStatusResponse);
    }

    public void rejectAdmin(String username) {
        var currentUser = this.getCurrentUser();
        if (currentUser.getRole() != User.Role.ROLE_ADMIN) {
            throw new RuntimeException("Пользователь не имеет доступа к данному запросу");
        }

        var user = getByUsername(username);
        if (user.getRole() == User.Role.ROLE_USER && user.getIsWaitingAdmin()) {
            user.setIsWaitingAdmin(false);
            save(user);

            var waitingAdminStatusResponse = new WaitingAdminStatusResponse(user.getRole(), user.getIsWaitingAdmin());

            webSocketController.sendWaitingAdminStatusToUser(username, waitingAdminStatusResponse);
        } else {
            throw new RuntimeException("Пользователь не может получить роль администратора");
        }
    }

    public List<String> getWaitingAdminUsernames() {
        var user = this.getCurrentUser();
        if (user.getRole() != User.Role.ROLE_ADMIN)
            throw new RuntimeException("Пользователь не имеет доступа к запросу");
        var users = repository.findByIsWaitingAdminTrue().orElse(new ArrayList<>());

        return users.stream().map(User::getUsername).toList();
    }

    public boolean isAdminExists() {
        return repository.existsByRole(User.Role.ROLE_ADMIN);
    }

    public boolean isUsernameExists(String username) {
        return repository.existsByUsername(username);
    }

    public void setWaitingAdmin() {
        var user = this.getCurrentUser();
        if (user.getRole() == User.Role.ROLE_USER) {
            user.setIsWaitingAdmin(true);
            this.save(user);
        }
    }
}
