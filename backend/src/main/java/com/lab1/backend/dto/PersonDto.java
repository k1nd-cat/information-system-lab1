package com.lab1.backend.dto;

import com.lab1.backend.entities.Person;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class PersonDto {
    private String passportID;
    private String name;
    private Person.Color eyeColor;
    private Person.Color hairColor;
    private Person.Location location;
    private Person.Country nationality;
}
