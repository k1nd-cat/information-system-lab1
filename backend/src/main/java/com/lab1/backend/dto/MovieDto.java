package com.lab1.backend.dto;

import com.lab1.backend.entities.Movie;
import com.lab1.backend.entities.Person;
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
