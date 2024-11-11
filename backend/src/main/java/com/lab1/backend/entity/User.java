package com.lab1.backend.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Entity
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "users", indexes = {
        @Index(name = "idx_login", columnList = "login")
})
public class User {

    @Id
    @Column(name = "login", unique = true, nullable = false)
    private String login;

    @JsonIgnore
    @Column(name = "password", nullable = false)
    private String password;

    @JsonIgnore
    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false)
    private Role role;

    @Column(name = "is_waiting_admin", nullable = false)
    private boolean isWaitingAdmin;

    @Column(name = "last_activity")
    private Date lastActivity;

    public enum Role {
        ADMIN,
        USER
    }
}
