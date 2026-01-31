package com.example.demo.service;

import com.example.demo.config.email.EmailSender;
import com.example.demo.entity.OrderHistory;
import com.example.demo.entity.User;
import com.example.demo.repository.OrderHistoryRepository;
import com.example.demo.repository.StatusRepository;
import com.example.demo.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.ConstraintViolationException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Date;

@Service
@RequiredArgsConstructor
@Transactional(noRollbackFor = {DataIntegrityViolationException.class, ConstraintViolationException.class, SQLIntegrityConstraintViolationException.class, SQLException.class})
public class OrderService {
    private final OrderHistoryRepository orderHistoryRepository;
    private final UserRepository userRepository;
    private final StatusRepository statusRepository;
    private final EmailSender emailSender;

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
    public ResponseEntity<Object> cancelOrder(Integer orderId, Integer cancelerUserId) {
        try {
            if (orderId == null) {
                return ResponseEntity.status(422).build();
            }
            OrderHistory searchedOrderHistory = orderHistoryRepository.getOrderHistoryById(orderId).orElse(null);
            if (searchedOrderHistory == null || searchedOrderHistory.getIsCanceled()) {
                return ResponseEntity.status(404).body("orderNotFound");
            }
            if (cancelerUserId != 0) {
                User cancelerUser = userRepository.getUserById(cancelerUserId).orElse(null);
                if (cancelerUser == null || cancelerUser.getIsDeleted()) {
                    return ResponseEntity.status(404).body("userNotFound");
                }
                searchedOrderHistory.setCancelerUser(cancelerUser);
            } else {
                searchedOrderHistory.setCancelerEmail(searchedOrderHistory.getEmail());
            }

            try {
                emailSender.sendEmailAboutCancelledOrder(searchedOrderHistory.getEmail());
            } catch (Exception e) {
                return ResponseEntity.internalServerError().body("emailSenderError");
            }

            searchedOrderHistory.setStatus(statusRepository.findById(3).get());
            searchedOrderHistory.setCanceled_at(new Date());
            searchedOrderHistory.setIsCanceled(true);
            orderHistoryRepository.save(searchedOrderHistory);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
