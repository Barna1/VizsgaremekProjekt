package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import tools.jackson.databind.JsonNode;

@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @PostMapping("/login")
    private ResponseEntity<Object> login(@RequestBody JsonNode requestBody) {
        return userService.login(requestBody.get("username").asText(null), requestBody.get("password").asText(null));
    }

    @PostMapping("/register")
    private ResponseEntity<Object> register(@RequestBody User newUser) {
        return userService.register(newUser);
    }

    @PatchMapping("/{id}")
    private ResponseEntity<Object> update(@RequestBody JsonNode requestBody, @PathVariable("id") Integer id) {
        return userService.update(id, requestBody.get("username").asText(null), requestBody.get("email").asText(null));
    }
    @DeleteMapping("/{id}")
    private ResponseEntity<Object> delete(@PathVariable("id") Integer id) {
        return userService.delete(id);
    }
    @GetMapping("/vCode")
    private ResponseEntity<Object> getVerificationCode(@RequestParam("email") String email) {
        return userService.getVerificationCode(email);
    }
    @PostMapping("/check")
    private ResponseEntity<Object> checkVerificationCode(@RequestBody JsonNode requestBody) {
        return userService.checkVerificationCode(requestBody.get("vCode").asText(null), requestBody.get("email").asText(null));
    }
}
