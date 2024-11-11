package com.lab1.backend.service;

import com.lab1.backend.entity.User;
import com.lab1.backend.entity.model.Movie;
import com.lab1.backend.repository.model.MovieRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MovieService {

    private MovieRepository movieRepository;



    private boolean hasAccessRightsForUpdateMovie(Movie movie, User user) {
        if (movie.isModifiable() && user.getRole().equals(User.Role.ADMIN)) return true;
        return movie.getUser().getLogin().equals(user.getLogin());
    }

    private boolean hasAccessRightsForDeleteMovie(Movie movie, User user) {
        if (user.getRole().equals(User.Role.ADMIN)) return true;
        return movie.getUser().getLogin().equals(user.getLogin());
    }
}
