package com.lab1.lab1.model.user;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Tokens {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @OneToOne
    private Users user;

    private String token;
}
