package com.example.demo.controller;

import com.example.demo.service.BasketService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/basket")
public class BasketController {
    private final BasketService basketService;

    @GetMapping("/user/{id}")
    private ResponseEntity<Object> getBasketByUserId(@PathVariable("id") Integer userId) {
        return basketService.getBasketByUserId(userId);
    }
}
