package com.example.demo.controller;

import com.example.demo.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/order")

public class OrderController {
    private final OrderService orderService;

    @GetMapping("/user/{id}")
    public ResponseEntity<Object> getOrderHistoryByUserId(@PathVariable("id") Integer userId) {
        return orderService.getOrderHistoryByUserId(userId);
    }
}
