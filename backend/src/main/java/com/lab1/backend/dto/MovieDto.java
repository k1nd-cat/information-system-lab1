package com.lab1.backend.dto;

import com.lab1.backend.entity.model.Movie;
import com.lab1.backend.entity.model.Person;
import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MovieDto {
    private String name;
    private Movie.Coordinates coordinates;
    private java.util.Date creationDate;
    private int oscarsCount;
    private float budget;
    private Double totalBoxOffice;
    private Movie.MpaaRating mpaaRating;
    private Person director;
    private Person screenwriter;
    private Person operator;
    private long length;
    private int goldenPalmCount;
    private Long usaBoxOffice;
    private Movie.MovieGenre genre;
    private boolean modifiable;
}
