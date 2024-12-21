package com.lab1.backend.repository;

import com.lab1.backend.entities.Person;
import jakarta.validation.constraints.NotNull;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PersonRepository extends JpaRepository<Person, String> {
    Person findByPassportID(String id);

//    List<Person> findAll();
}
