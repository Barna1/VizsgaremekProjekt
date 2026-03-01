package com.example.demo.controller;

import com.example.demo.entity.OrderHistory;
import com.example.demo.service.OrderService;
import com.fasterxml.jackson.databind.JsonNode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/order")

public class OrderController {
    private final OrderService orderService;

    @GetMapping("/user/{id}")
    public ResponseEntity<Object> getOrderHistoryByUserId(@PathVariable("id") Integer userId) {
        return orderService.getOrderHistoryByUserId(userId);
    }
    @DeleteMapping("/cancel")
    public ResponseEntity<Object> cancelOrder(@RequestParam(name = "orderId") Integer orderId, @RequestParam(name = "userId") Integer userId) {
        return orderService.cancelOrder(orderId, userId);
    }
    @GetMapping
    public ResponseEntity<Object> getAllOrder() {
        return orderService.getAllOrder();
    }
    @PostMapping("/basket/{id}")
    public ResponseEntity<Object> sendOrder(@RequestBody OrderHistory newOrder, @PathVariable("id") Integer basketId) {
        return orderService.sendOrder(newOrder, basketId);
    }
}
