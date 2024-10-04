package com.lab1.lab1.service.user;

import com.lab1.lab1.dto.user.status.WaitApproveResponse;
import com.lab1.lab1.model.user.User;
import com.lab1.lab1.repository.user.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class UserStatusService {

    private final UserRepository repository;

    public Object waitingApprove(String token) {
        var userOpt = repository.findByToken(token);
        if (userOpt.isEmpty()) {
            return Collections.singletonMap("error", "user not found");
        }

        var user = userOpt.get();
        if (!Boolean.TRUE.equals(user.getIsAdmin())) {
            return Collections.singletonMap("error", "insufficient access rights");
        }

        List<User> userList;
        var userListOpt = repository.searchUsersByIsAdmin(false);
        if (userListOpt.isPresent()) {
            userList = userListOpt.get();
        } else {
            return new ArrayList<WaitApproveResponse>();
        }

        return userList.stream()
                .map(currentUser -> {
                    var userResponse = new WaitApproveResponse();
                    userResponse.setLogin(currentUser.getLogin());
                    return userResponse;
                })
                .collect(Collectors.toList());
    }
}
