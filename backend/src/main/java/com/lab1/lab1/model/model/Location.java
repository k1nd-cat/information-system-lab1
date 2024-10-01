package com.lab1.lab1.model.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Location {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private Long x; //Поле не может быть null

    private long y;

    @Column(nullable = false)
    private Float z; //Поле не может быть null
}
