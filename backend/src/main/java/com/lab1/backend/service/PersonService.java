package com.lab1.backend.service;

import com.lab1.backend.entities.Person;
import com.lab1.backend.repository.MovieRepository;
import com.lab1.backend.repository.PersonRepository;
import lombok.Data;
import org.springframework.stereotype.Service;

import java.util.List;

@Data
@Service
public class PersonService {

    private final PersonRepository repository;

    private final MovieRepository movieRepository;

//    private final MovieService movieService;

    public Person save(Person person) {
        return repository.save(person);
    }

    public List<Person> getAll() {
        return repository.findAll();
    }

    public void deletePerson(String id) {
        repository.deleteById(id);
    }

    public List<Person> getWithZeroOscarCount() {
        return movieRepository.getWithZeroOscarCount();
    }
}
