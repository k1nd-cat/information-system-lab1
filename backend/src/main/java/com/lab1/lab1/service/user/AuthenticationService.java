package com.lab1.lab1.service.user;

import com.lab1.lab1.dto.user.authentication.request.UserLoginRequest;
import com.lab1.lab1.dto.user.authentication.request.UserLogoutRequest;
import com.lab1.lab1.model.user.User;
import com.lab1.lab1.repository.user.UserAuthenticationRepository;
import com.lab1.lab1.utils.Secutiry;

import java.util.*;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
@AllArgsConstructor
public class AuthenticationService {

    private final UserAuthenticationRepository repository;

    public Map<String, Object> login(UserLoginRequest request) {
        var secutiry = new Secutiry();
        var userOpt = repository.findById(request.getLogin());
        if (userOpt.isEmpty()) {
            return Collections.singletonMap("error", "user does not exist");
        }

        var user = userOpt.get();
        if (!secutiry.verifyPassword(request.getPassword(), user.getPassword())) {
            return Collections.singletonMap("error", "invalid password");
        }

        user.setToken(secutiry.generateToken(user.getLogin()));
        repository.save(user);
        var response = new HashMap<String, Object>();
        response.put("token", user.getToken());
        response.put("isAdmin", user.getIsAdmin());

        return response;
    }

    public Map<String, Object> register(UserLoginRequest request) {
        var secutiry = new Secutiry();

        if (!StringUtils.hasLength(StringUtils.trimAllWhitespace(request.getLogin())) || !StringUtils.hasLength(StringUtils.trimAllWhitespace(request.getPassword()))) {
            return Collections.singletonMap("error", "No login / password");
        }

        if (!secutiry.isValidPassword(request.getPassword())) {
            return Collections.singletonMap("error", "invalid password");
        }

        if (!secutiry.isValidLogin(request.getLogin())) {
            return Collections.singletonMap("error", "invalid login");
        }

        Optional<User> userOpt = repository.findById(request.getLogin());
        if (userOpt.isPresent()) {
            return Collections.singletonMap("error", "user already exists");
        }

        var user = new User();
        try {
            var passwordHash = secutiry.getMd5Hash(request.getPassword());
            var token = secutiry.generateToken(request.getLogin());
            user.setPassword(passwordHash);
            user.setLogin(request.getLogin());
            user.setToken(token);
            user.setIsAdmin(request.getIsAdmin());
            repository.save(user);
        } catch (Exception e) {
            return Collections.singletonMap("error", "Error in creating user");
        }

        var response = new HashMap<String, Object>();
        response.put("token", user.getToken());
        response.put("isAdmin", user.getIsAdmin());

        return response;
    }

    public void logout(UserLogoutRequest request) {
        String token = request.getToken();
        if (!StringUtils.hasLength(StringUtils.trimAllWhitespace(token))) return;
        Optional<User> userOpt = repository.findByToken(token);
        if (userOpt.isEmpty()) return;
        var user = userOpt.get();
        user.setToken(null);
        repository.save(user);
    }
}
