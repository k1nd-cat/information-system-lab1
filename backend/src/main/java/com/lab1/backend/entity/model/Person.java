package com.lab1.backend.entity.model;

import com.lab1.backend.dto.PersonDto;
import com.lab1.backend.entity.User;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Person {

    @Id
    @Column(length = 34, unique = true, nullable = false, name = "passport_id")
    @NotNull
    @NotBlank
    private String passportID; //Длина строки не должна быть больше 34, Значение этого поля должно быть уникальным, Поле может быть null

    @Column(nullable = false)
    @NotBlank
    @NotNull
    private String name; //Поле не может быть null, Строка не может быть пустой

    @Column(nullable = false, name = "eye_color")
    @Enumerated(EnumType.STRING)
    @NotNull
    private Color eyeColor; //Поле может быть null

    @Column(nullable = false, name = "hair_color")
    @Enumerated(EnumType.STRING)
    @NotNull
    private Color hairColor; //Поле может быть null

    @Embedded
    @NotNull
    private Location location; //Поле может быть null

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @NotNull
    private Country nationality; //Поле не может быть null

    @ManyToOne
    @NotNull
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Location {

        @NotNull
        private Long x; //Поле не может быть null

        private long y;

        @NotNull
        private Float z; //Поле не может быть null

    }

    public enum Country {
        RUSSIA,
        INDIA,
        JAPAN;
    }

    public enum Color {
        RED,
        BLACK,
        WHITE;
    }

    public static Person fromDto(PersonDto personDto) {
        return Person.builder()
                .passportID(personDto.getPassportID())
                .name(personDto.getName())
                .eyeColor(personDto.getEyeColor())
                .hairColor(personDto.getHairColor())
                .location(personDto.getLocation())
                .nationality(personDto.getNationality())
                .build();
    }

    public static Person fromDto(PersonDto personDto, User user) {
        var person = fromDto(personDto);
        person.setUser(user);

        return person;
    }
}
