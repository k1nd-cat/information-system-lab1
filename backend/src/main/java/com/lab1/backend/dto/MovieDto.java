package com.lab1.backend.dto;

import com.lab1.backend.entities.Movie;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class MovieDto {
    private Long id;

    @NotNull(message = "Значение не может отсутствовать")
    @NotBlank(message = "Значение не может состоять только из пробелов")
    private String name;

    @NotNull(message = "Значение не может отсутствовать")
    private Coordinates coordinates;

    private java.util.Date creationDate;

    @NotNull(message = "Значение не может отсутствовать")
    @Positive(message = "Значение может быть только положительным")
    private Integer oscarCount;

    @NotNull(message = "Значение не может отсутствовать")
    @Positive(message = "Значение может быть только положительным")
    private Float budget;

    @NotNull(message = "Значение не может отсутствовать")
    @Positive(message = "Значение может быть только положительным")
    private Double totalBoxOffice;

    private Movie.MpaaRating mpaaRating;

    @Valid
    @NotNull(message = "Значение не может отсутствовать")
    private PersonDto director;

    @Valid
    private PersonDto screenwriter;

    @Valid
    @NotNull(message = "Значение не может отсутствовать")
    private PersonDto operator;

    @NotNull(message = "Значение не может отсутствовать")
    @Positive(message = "Значение может быть только положительным")
    private Long length;

    @NotNull(message = "Значение не может отсутствовать")
    @Positive(message = "Значение может быть только положительным")
    private Integer goldenPalmCount;

    @Positive(message = "Значение может быть только положительным")
    private Long usaBoxOffice;

    @NotNull(message = "Значение не может отсутствовать")
    private Movie.MovieGenre genre;

    private Boolean isEditable;

    private String creatorName;

    @Data
    @Builder
    @AllArgsConstructor
    public static class Coordinates {

        @NotNull(message = "Значение не может отсутствовать")
        Double x;

        @NotNull(message = "Значение не может отсутствовать")
        private Long y;
    }
}
