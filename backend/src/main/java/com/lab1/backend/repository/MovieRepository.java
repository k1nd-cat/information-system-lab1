package com.lab1.backend.repository;

import com.lab1.backend.entities.Movie;
import com.lab1.backend.entities.Person;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface MovieRepository extends JpaRepository<Movie, Long> {
    Optional<Movie> findMovieById(Long id);

//    Page<Movie> findAll(Pageable pageable);

    List<Movie> findAll();

    @Query(
            value = "SELECT * FROM get_movies_by_prefix(:prefixName)",
            nativeQuery = true
    )
    List<Movie> findByPrefixName(@Param("prefixName") String prefixName);

    @Query(
            value = "SELECT * FROM get_movies_by_golden_palm_count(:minGoldenPalmCount)",
            nativeQuery = true
    )
    List<Movie> findByMinGoldenPalmCount(@Param("minGoldenPalmCount") Integer minGoldenPalmCount);

    @Query(
            value = "SELECT * FROM get_movies_with_unique_usa_box_office()",
            nativeQuery = true
    )
    List<Movie> findByUniqueUsaBoxOffice();

    @Query("SELECT COUNT(m) FROM Movie m " +
            "JOIN m.director d " +
            "JOIN m.screenwriter s " +
            "JOIN m.operator o " +
            "WHERE d.passportID = :personId OR s.passportID = :personId OR o.passportID = :personId")
    Long countMoviesWithPerson(@Param("personId") String personId);

    @Modifying
    @Transactional
    @Query(value = "SELECT * FROM update_oscar_count(:p_username, :p_increment)", nativeQuery = true)
    List<Movie> updateOscarCount(@Param("p_username") String username, @Param("p_increment") int increment);
}

