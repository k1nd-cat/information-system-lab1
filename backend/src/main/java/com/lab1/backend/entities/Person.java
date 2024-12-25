package com.lab1.backend.entities;

import com.lab1.backend.dto.PersonDto;
import jakarta.persistence.*;
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
    private String passportID; //Длина строки не должна быть больше 34, Значение этого поля должно быть уникальным, Поле может быть null

    @Column(nullable = false)
    private String name; //Поле не может быть null, Строка не может быть пустой

    @Column(nullable = false, name = "eye_color")
    @Enumerated(EnumType.STRING)
    private Color eyeColor; //Поле может быть null

    @Column(nullable = false, name = "hair_color")
    @Enumerated(EnumType.STRING)
    private Color hairColor; //Поле может быть null

    @Embedded
    private Location location; //Поле может быть null

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Country nationality; //Поле не может быть null

    @Data
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Location {

        private Long x; //Поле не может быть null

        private long y;

        private Float z; //Поле не может быть null

        public static Location fromDto(PersonDto.Location dto) {
            if (dto == null) return null;
            return Location.builder()
                    .x(dto.getX())
                    .y(dto.getY())
                    .z(dto.getZ())
                    .build();
        }
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

    public static Person fromDto(PersonDto dto) {
        return Person.builder()
                .passportID(dto.getPassportID())
                .name(dto.getName())
                .eyeColor(dto.getEyeColor())
                .hairColor(dto.getHairColor())
                .location(dto.getLocation() != null
                        ? Location.fromDto(dto.getLocation())
                        : null
                        )
                .nationality(dto.getNationality())
                .build();
    }

    public PersonDto toDto() {
        return PersonDto.builder()
                .passportID(passportID)
                .name(name)
                .eyeColor(eyeColor)
                .hairColor(hairColor)
                .location(location != null
                        ? new PersonDto.Location(location.x, location.y, location.z)
                        : null)
                .nationality(nationality)
                .build();
    }
}
