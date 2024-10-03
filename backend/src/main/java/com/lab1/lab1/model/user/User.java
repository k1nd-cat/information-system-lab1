package com.lab1.lab1.model.user;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "users")
public class User {

    @Id
    @Column(nullable = false, unique = true)
    private String login;

    @Column(unique = true)
    private String token;

    @Column(nullable = false)
    private String password;

    Boolean isAdmin;
}
