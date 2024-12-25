package com.lab1.backend.repository;

import com.lab1.backend.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsername(String username);

    boolean existsByUsername(String username);

    boolean existsByRole(User.Role role);

    Optional<List<User>> findAllByIsWaitingAdmin(Boolean isWaitingAdmin);

    Optional<List<User>> findByIsWaitingAdminTrue();


}
