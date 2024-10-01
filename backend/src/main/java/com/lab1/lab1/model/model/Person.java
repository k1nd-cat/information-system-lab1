package com.lab1.lab1.model.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Entity
@Data
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    @NotBlank
    private String name; //Поле не может быть null, Строка не может быть пустой

    @Enumerated(EnumType.STRING)
    private Color eyeColor; //Поле может быть null

    @Enumerated(EnumType.STRING)
    private Color hairColor; //Поле может быть null

    @ManyToOne
    private Location location; //Поле может быть null

    @Column(length = 34, unique = true)
    private String passportID; //Длина строки не должна быть больше 34, Значение этого поля должно быть уникальным, Поле может быть null

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Country nationality; //Поле не может быть null
}
