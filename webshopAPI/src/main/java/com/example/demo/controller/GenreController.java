package com.example.demo.controller;

import com.example.demo.service.GenreService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/genre")
public class GenreController {
    private final GenreService genreService;

    @GetMapping("")
    private ResponseEntity<Object> getAllGenre() {
        return genreService.getAllGenre();
    }
}
