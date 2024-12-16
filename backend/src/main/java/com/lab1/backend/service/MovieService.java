package com.lab1.backend.service;

import com.lab1.backend.entities.User;
import com.lab1.backend.entities.Movie;
import com.lab1.backend.repository.MovieRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MovieService {

    private MovieRepository movieRepository;

    private boolean hasAccessRightsForUpdateMovie(Movie movie, User user) {
        if (movie.isModifiable() && user.getRole().equals(User.Role.ROLE_ADMIN)) return true;
        return movie.getUser().getUsername().equals(user.getUsername());
    }

    private boolean hasAccessRightsForDeleteMovie(Movie movie, User user) {
        if (user.getRole().equals(User.Role.ROLE_ADMIN)) return true;
        return movie.getUser().getUsername().equals(user.getUsername());
    }
}
