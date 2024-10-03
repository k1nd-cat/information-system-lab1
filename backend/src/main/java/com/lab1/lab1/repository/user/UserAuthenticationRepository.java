package com.lab1.lab1.repository.user;

import com.lab1.lab1.model.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserAuthenticationRepository extends JpaRepository<User, String> {
    Optional<User> findByToken(String token);
}
