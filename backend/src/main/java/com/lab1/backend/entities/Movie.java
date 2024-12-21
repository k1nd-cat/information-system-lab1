package com.lab1.backend.entities;

import com.lab1.backend.dto.MovieDto;
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

    @Column(nullable = false, name = "oscar_count")
    @Min(1)
    private int oscarCount; //Значение поля должно быть больше 0

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

    @ManyToOne(optional = false, cascade = CascadeType.ALL)
    @JoinColumn(name = "director_id", nullable = false)
    @NotNull
    private Person director; //Поле не может быть null

    @ManyToOne(optional = true, cascade = CascadeType.ALL)
    @JoinColumn(name = "screenwriter_id", nullable = true)
    private Person screenwriter;

    @ManyToOne(optional = false, cascade = CascadeType.ALL)
    @JoinColumn(name = "operator_id", nullable = false)
    @NotNull
    private Person operator; //Поле не может быть null

    @Column(nullable = false)
    @Min(1)
    private long length; //Значение поля должно быть больше 0

    @Column(nullable = false, name = "golden_palm_count")
    @Min(1)
    private int goldenPalmCount; //Значение поля должно быть больше 0

    @Column(name = "usa_box_office", nullable = true)
    @Positive
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
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Coordinates {

        private double x;

        @NotNull
        private Long y; //Поле не может быть null

        public static Coordinates fromDto(MovieDto.Coordinates dto) {
            return Coordinates.builder()
                    .x(dto.getX())
                    .y(dto.getY())
                    .build();
        }
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

    public static Movie fromDto(MovieDto dto, User user) {
        final var movie = fromDto(dto);
        movie.setCreationDate(new java.util.Date());
        movie.setModifiable(dto.getIsEditable());
        movie.setUser(user);

        return movie;
    }

    public static Movie fromDto(MovieDto dto, Movie movieFromDb) {
        final var movie = fromDto(dto);
        movie.setId(movieFromDb.getId());
        movie.setCreationDate(movieFromDb.getCreationDate());
        movie.setModifiable(movieFromDb.modifiable);
        movie.setUser(movieFromDb.getUser());

        return movie;
    }

    private static Movie fromDto(MovieDto dto) {
        return Movie.builder()
                .name(dto.getName())
                .coordinates(Coordinates.fromDto(dto.getCoordinates()))
                .genre(dto.getGenre())
                .mpaaRating(dto.getMpaaRating())
                .director(Person.fromDto(dto.getDirector()))
                .screenwriter(
                        dto.getScreenwriter() == null
                                ? null
                                : Person.fromDto(dto.getScreenwriter())
                )
                .operator(Person.fromDto(dto.getOperator()))
                .oscarCount(dto.getOscarCount())
                .budget(dto.getBudget())
                .totalBoxOffice(dto.getTotalBoxOffice())
                .length(dto.getLength())
                .goldenPalmCount(dto.getGoldenPalmCount())
                .usaBoxOffice(dto.getUsaBoxOffice())
                .build();
    }

    public MovieDto toDto() {
        return MovieDto.builder()
                .id(id)
                .name(name)
                .creationDate(creationDate)
                .coordinates(new MovieDto.Coordinates(coordinates.x, coordinates.y))
                .genre(genre)
                .mpaaRating(mpaaRating)
                .director(director.toDto())
                .screenwriter(screenwriter.toDto())
                .operator(operator.toDto())
                .oscarCount(oscarCount)
                .budget(budget)
                .totalBoxOffice(totalBoxOffice)
                .length(length)
                .goldenPalmCount(goldenPalmCount)
                .usaBoxOffice(usaBoxOffice)
                .creatorName(user.getUsername())
                .isEditable(modifiable)
                .build();
    }
}
