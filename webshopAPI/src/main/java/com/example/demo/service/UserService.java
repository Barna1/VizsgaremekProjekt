package com.example.demo.service;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public ResponseEntity<Object> login(String username, String password) {
        try {
            if (username == null || password == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserByUsername(username).orElse(null);
            if (searchedUser == null) {
                return ResponseEntity.notFound().build();
            } else {
                if (!passwordEncoder.matches(password, searchedUser.getPassword())) {
                    return ResponseEntity.notFound().build();
                } else {
                    searchedUser.setLastLogin(new Date());
                    userRepository.save(searchedUser);
                    return ResponseEntity.ok().build();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
