package com.example.demo.controller;

import com.example.demo.entity.Genre;
import com.example.demo.service.GenreService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/genre")
public class GenreController {
    private final GenreService genreService;

    @GetMapping("")
    private ResponseEntity<Object> getAllGenre() {
        return genreService.getAllGenre();
    }
    @PostMapping("")
    private ResponseEntity<Object> addGenre(@RequestBody Genre newGenre) {
        return genreService.addGenre(newGenre);
    }
    @PutMapping("")
    private ResponseEntity<Object> updateGenre(@RequestBody Genre updatedGenre) {
        return genreService.updateGenre(updatedGenre);
    }
    @DeleteMapping("/{id}")
    private ResponseEntity<Object> deleteGenre(@PathVariable("id") Integer id) {
        return genreService.deleteGenre(id);
    }
}
