package com.lab1.backend.dto;

import com.lab1.backend.entities.Movie;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class MovieRequest {
    private Long id;

    @NotNull
    @NotBlank
    private String name;

    @NotNull
    private Coordinates coordinates;

    @NotNull
    @Positive
    private Integer oscarCount;

    @Positive
    @NotNull
    private Float budget;

    @Positive
    @NotNull
    private Double totalBoxOffice;

    private Movie.MpaaRating mpaaRating;

    @NotNull
    private PersonRequest director;

    private PersonRequest screenwriter;

    @NotNull
    private PersonRequest operator;

    @NotNull
    @Positive
    private Long length;

    @NotNull
    @Positive
    private Integer goldenPalmCount;

    @Positive
    private Long usaBoxOffice;

    @NotNull
    private Movie.MovieGenre genre;

    private Boolean isEditable;

    private String creatorName;

    @Data
    @AllArgsConstructor
    public static class Coordinates {

        @NotNull
        Double x;

        @NotNull
        private Long y;
    }
}
