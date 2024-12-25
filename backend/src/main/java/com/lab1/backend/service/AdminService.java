package com.lab1.backend.service;

import com.lab1.backend.dto.MessageResponse;
import com.lab1.backend.dto.UpdatedRoleResponse;
import com.lab1.backend.entities.User;
import com.lab1.backend.repository.UserRepository;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.nio.file.AccessDeniedException;
import java.util.ArrayList;
import java.util.List;

@Data
@Service
public class AdminService {

    private final UserRepository repository;

    private final UserService userService;

    private final JwtService jwtService;

    private final WebSocketService webSocketService;

    public MessageResponse setUserRole(String username, User.Role newRole) throws AccessDeniedException {
        checkCurrentUserIsAdmin();

        var user = userService.getByUsername(username);
        if (user.getRole() != User.Role.ROLE_USER || !user.getIsWaitingAdmin())
            throw new DataIntegrityViolationException("Пользователь не отправлял заявку на администратора");

        user.setIsWaitingAdmin(false);
        user.setRole(newRole);
        userService.save(user);

        webSocketService.sendUpdatedRoleForUser(
                username,
                new UpdatedRoleResponse(
                    user.getRole(),
                    user.getIsWaitingAdmin(),
                    jwtService.generateToken(user)
                )
        );

        return new MessageResponse("Пользователь назначен на роль администратора");
    }

    public List<String> getWaitingAdminUsernames() throws AccessDeniedException {
        checkCurrentUserIsAdmin();
        var users = repository.findByIsWaitingAdminTrue().orElse(new ArrayList<>());

        return users.stream().map(User::getUsername).toList();
    }

    private void checkCurrentUserIsAdmin() throws AccessDeniedException {
        var currentUser = userService.getCurrentUser();
        if (currentUser.getRole() != User.Role.ROLE_ADMIN)
            throw new AccessDeniedException("Роль пользователя не позволяет выполнять операции от имени администратора");
    }
}
