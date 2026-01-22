package com.example.demo.service;

import com.example.demo.entity.Basket;
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

    public ResponseEntity<Object> register(User newUser) {
        try {
            if (newUser == null) {
                return ResponseEntity.status(422).build();
            }

            if (newUser.getId() != null) {
                return ResponseEntity.status(415).body("invalidObject");
            } else {
                newUser.setPassword(passwordEncoder.encode(newUser.getPassword()));
                newUser.setBasket(new Basket());
                userRepository.save(newUser);

                return ResponseEntity.ok().build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public ResponseEntity<Object> update(Integer id, String username) {
        try {
            if (id == null || username == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserById(id).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> delete(Integer id) {
        try {
            if (id == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserById(id).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            } else {
                userRepository.deleteUserById(id);
                return ResponseEntity.ok().build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
