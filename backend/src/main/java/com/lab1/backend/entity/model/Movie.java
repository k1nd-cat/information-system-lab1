package com.lab1.backend.entity.model;

import com.lab1.backend.dto.MovieDto;
import com.lab1.backend.entity.User;
import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Movie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id; //Значение поля должно быть больше 0, Значение этого поля должно быть уникальным, Значение этого поля должно генерироваться автоматически

    @Column(nullable = false)
    @NotNull
    @NotBlank
    private String name; //Поле не может быть null, Строка не может быть пустой

    @NotNull
    @Embedded
    private Coordinates coordinates; //Поле не может быть null

    @Column(nullable = false, name = "creation_date")
    @Temporal(TemporalType.TIMESTAMP)
    @NotNull
    private java.util.Date creationDate; //Поле не может быть null, Значение этого поля должно генерироваться автоматически

    @Column(nullable = false, name = "oscars_count")
    @Min(1)
    private int oscarsCount; //Значение поля должно быть больше 0

    @Column(nullable = false)
    @Positive
    private float budget; //Значение поля должно быть больше 0

    @Column(nullable = false, name = "total_box_office")
    @Positive
    @NotNull
    private Double totalBoxOffice; //Поле не может быть null, Значение поля должно быть больше 0

    @Column(name = "mpaa_rating")
    @Enumerated(EnumType.STRING)
    @NotNull
    private MpaaRating mpaaRating; //Поле может быть null

    @ManyToOne(optional = false)
    @JoinColumn(name = "person_id", nullable = false)
    @NotNull
    private Person director; //Поле не может быть null

    @ManyToOne
    @JoinColumn(name = "screenwriter_id")
    private Person screenwriter;

    @ManyToOne(optional = false)
    @JoinColumn(name = "operator_id", nullable = false)
    @NotNull
    private Person operator; //Поле не может быть null

    @Column(nullable = false)
    @Min(1)
    private long length; //Значение поля должно быть больше 0

    @Column(nullable = false, name = "golden_palm_count")
    @Min(1)
    private int goldenPalmCount; //Значение поля должно быть больше 0

    @Column(name = "usa_box_office", nullable = false)
    @Min(1)
    @NotNull
    private Long usaBoxOffice; //Поле может быть null, Значение поля должно быть больше 0

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @NotNull
    private MovieGenre genre; //Поле не может быть null

    @Column(nullable = false)
    private boolean modifiable;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Coordinates {

        private double x;

        @NotNull
        private Long y; //Поле не может быть null
    }

    public enum MpaaRating {
        G,
        PG_13,
        NC_17;
    }

    public enum MovieGenre {
        ACTION,
        WESTERN,
        FANTASY;
    }

    public static Movie fromDto(MovieDto movieDto, Person director, Person screenwriter, Person operator) {
        return Movie.builder()
                .name(movieDto.getName())
                .coordinates(movieDto.getCoordinates())
                .creationDate(movieDto.getCreationDate())
                .oscarsCount(movieDto.getOscarsCount())
                .budget(movieDto.getBudget())
                .totalBoxOffice(movieDto.getTotalBoxOffice())
                .mpaaRating(movieDto.getMpaaRating())
                .director(director)
                .screenwriter(screenwriter)
                .operator(operator)
                .length(movieDto.getLength())
                .goldenPalmCount(movieDto.getGoldenPalmCount())
                .usaBoxOffice(movieDto.getUsaBoxOffice())
                .genre(movieDto.getGenre())
                .modifiable(movieDto.isModifiable())
                .build();
    }

    public static Movie fromDto(MovieDto movieDto, Person director, Person screenwriter, Person operator, User user) {
        var movie = Movie.fromDto(movieDto, director, screenwriter, operator);
        movie.setUser(user);

        return movie;
    }
}
