package com.lab1.backend.dto;

import com.lab1.backend.entities.Person;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class PersonDto {

    @NotNull
    @NotBlank
    private String passportID;

    @NotNull
    @NotBlank
    @Size(max = 34)
    private String name;

    @NotNull
    private Person.Color eyeColor;

    @NotNull
    private Person.Color hairColor;

    private Location location;

    @NotNull
    private Person.Country nationality;

    @Data
    @Builder
    @AllArgsConstructor
    public static class Location {
        @NotNull
        private Long x;

        @NotNull
        private Long y;

        @NotNull
        private Float z;
    }
}
