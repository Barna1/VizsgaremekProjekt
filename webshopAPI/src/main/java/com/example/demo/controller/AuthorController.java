package com.example.demo.controller;

import com.example.demo.entity.Author;
import com.example.demo.service.AuthorService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/author")
@RequiredArgsConstructor
public class AuthorController {
    private final AuthorService authorService;

    @GetMapping("")
    private ResponseEntity<Object> getAllAuthor() {
        return authorService.getAllAuthor();
    }
    @PostMapping("")
    private ResponseEntity<Object> addAuthor(@RequestBody Author newAuthor) {
        return authorService.addAuthor(newAuthor);
    }
    @DeleteMapping("/{id}")
    private ResponseEntity<Object> deleteAuthor(@PathVariable("id") Integer id) {
        return authorService.deleteAuthor(id);
    }
}
