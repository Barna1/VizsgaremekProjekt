package com.example.demo.controller;

import com.example.demo.service.BasketService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import tools.jackson.databind.JsonNode;

@RequiredArgsConstructor
@RestController
@RequestMapping("/basket")
public class BasketController {
    private final com.example.demo.service.BasketService basketService;

    @GetMapping("/user/{id}")
    private ResponseEntity<Object> getBasketByUserId(@PathVariable("id") Integer userId) {
        return basketService.getBasketByUserId(userId);
    }
    @DeleteMapping("/book")
    private ResponseEntity<Object> deleteProductFromBasket(@RequestParam("basketProductId") Integer basketProductId, @RequestParam("basketId") Integer basketId) {
        return basketService.deleteProductFromBasket(basketProductId, basketId);
    }
    @PatchMapping("/{id}")
    private ResponseEntity<Object> changeAmountOfProduct(@RequestBody JsonNode requestBody, @PathVariable("id") Integer basketId) {
        return basketService.changeAmountOfProduct(basketId, requestBody.get("productId").asInt(0), requestBody.get("newAmount").asInt(-1));
    }
    @PostMapping("/{id}")
    private ResponseEntity<Object> addProductToBasket(@RequestBody JsonNode requestBody, @PathVariable("id") Integer basketId) {
        return basketService.addProductToBasket(requestBody.get("productId").asInt(0), requestBody.get("amount").asInt(-1), basketId);
    }
    @DeleteMapping("/{id}/clear")
    private ResponseEntity<Object> clearBasket(@PathVariable("id") Integer basketId) {
        return basketService.clearBasket(basketId);
    }
}
