package com.lab1.backend.repository;

import com.lab1.backend.entities.Person;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PersonRepository extends JpaRepository<Person, String> {
    public Person findByPassportID(String id);
}
