package com.lab1.lab1.model.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Entity
@Data
public class Movie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id; //Значение поля должно быть больше 0, Значение этого поля должно быть уникальным, Значение этого поля должно генерироваться автоматически

    @Column(nullable = false)
    @NotBlank
    private String name; //Поле не может быть null, Строка не может быть пустой

    @ManyToOne
    private Coordinates coordinates; //Поле не может быть null

    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date creationDate; //Поле не может быть null, Значение этого поля должно генерироваться автоматически

    @Column(nullable = false)
    @Min(1)
    private int oscarsCount; //Значение поля должно быть больше 0

    @Column(nullable = false)
    @Min(0)
    private float budget; //Значение поля должно быть больше 0

    @Column(nullable = false)
    @Min(0)
    private Double totalBoxOffice; //Поле не может быть null, Значение поля должно быть больше 0

    @Enumerated(EnumType.STRING)
    private MpaaRating mpaaRating; //Поле может быть null

    @ManyToOne(optional = false)
    private Person director; //Поле не может быть null

    @ManyToOne
    private Person screenwriter;

    @ManyToOne(optional = false)
    private Person operator; //Поле не может быть null

    @Column(nullable = false)
    @Min(1)
    private long length; //Значение поля должно быть больше 0

    @Column(nullable = false)
    @Min(1)
    private int goldenPalmCount; //Значение поля должно быть больше 0

    @Min(0)
    private Long usaBoxOffice; //Поле может быть null, Значение поля должно быть больше 0

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MovieGenre genre; //Поле не может быть null

}