package com.example.demo.controller;

import com.example.demo.service.BasketService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/basket")
public class BasketController {
    private final BasketService basketService;

    @GetMapping("/user/{id}")
    private ResponseEntity<Object> getBasketByUserId(@PathVariable("id") Integer userId) {
        return basketService.getBasketByUserId(userId);
    }
    @DeleteMapping("/book")
    private ResponseEntity<Object> deleteProductFromBasket(@RequestParam("basketProductId") Integer basketProductId, @RequestParam("basketId") Integer basketId) {
        return basketService.deleteProductFromBasket(basketProductId, basketId);
    }
}
