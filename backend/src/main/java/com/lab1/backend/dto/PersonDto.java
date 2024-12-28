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

    @NotNull(message = "Значение не может отсутствовать")
    @NotBlank(message = "Значение не может состоять только из пробелов")
    private String passportID;

    @NotNull(message = "Значение не может отсутствовать")
    @NotBlank(message = "Значение не может состоять только из пробелов")
    @Size(max = 34, message = "Максимальное количество символов: 34")
    private String name;

    @NotNull(message = "Значение не может отсутствовать")
    private Person.Color eyeColor;

    @NotNull(message = "Значение не может отсутствовать")
    private Person.Color hairColor;

    private Location location;

    @NotNull(message = "Значение не может отсутствовать")
    private Person.Country nationality;

    private String creatorName;

    private Boolean isEditable;

    @Data
    @Builder
    @AllArgsConstructor
    public static class Location {
        @NotNull(message = "Значение не может отсутствовать")
        private Long x;

        @NotNull(message = "Значение не может отсутствовать")
        private Long y;

        @NotNull(message = "Значение не может отсутствовать")
        private Float z;
    }
}
