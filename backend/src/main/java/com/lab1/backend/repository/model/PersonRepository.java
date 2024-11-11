package com.lab1.backend.repository.model;

import com.lab1.backend.entity.model.Person;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PersonRepository extends JpaRepository<Person, String> {
    public Person findByPassportID(String id);
}
