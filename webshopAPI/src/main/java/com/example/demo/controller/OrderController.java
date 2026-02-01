package com.example.demo.controller;

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
    @DeleteMapping("/cancel/{id}")
    public ResponseEntity<Object> cancelOrder(@PathVariable("id") Integer orderId, @RequestBody JsonNode requestBody) {
        return orderService.cancelOrder(orderId, requestBody.get("cancelerUserId").asInt());
    }
    @GetMapping("/search")
    public ResponseEntity<Object> getOrderHistoryByVCode(@RequestParam("email") String email, @RequestParam("vCode") String vCode) {
        return orderService.getOrderHistoryByVCode(email, vCode);
    }
    @GetMapping("")
    public ResponseEntity<Object> getAllOrder() {
        return orderService.getAllOrder();
    }
}
