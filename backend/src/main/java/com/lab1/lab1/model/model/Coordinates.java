package com.lab1.lab1.model.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import lombok.Data;

@Entity
@Data
public class Coordinates {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Min(-945)
    private long x; //Значение поля должно быть больше -946

    @Column(nullable = false)
    private Double y; //Поле не может быть null
}
