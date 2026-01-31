package com.example.demo.service;

import com.example.demo.entity.User;
import com.example.demo.repository.OrderHistoryRepository;
import com.example.demo.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.ConstraintViolationException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

@Service
@RequiredArgsConstructor
@Transactional(noRollbackFor = {DataIntegrityViolationException.class, ConstraintViolationException.class, SQLIntegrityConstraintViolationException.class, SQLException.class})
public class OrderService {
    private final OrderHistoryRepository orderHistoryRepository;
    private final UserRepository userRepository;

    public ResponseEntity<Object> getOrderHistoryByUserId(Integer userId) {
        try {
            if (userId == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserById(userId).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }

            return ResponseEntity.ok().body(orderHistoryRepository.getOrderHistoryByUserId(userId));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
