package com.example.demo.controller;

import com.example.demo.service.BookService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class BookController {
    private final BookService bookService;
    
    @GetMapping("")
    private ResponseEntity<Object> getBooks(Pageable pageable) {
        return bookService.getBooks(pageable);
    }
    @GetMapping("/{id}")
    private ResponseEntity<Object> getBookById(@PathVariable("id") Integer id) {
        return bookService.getBookById(id);
    }
    @GetMapping("/author/{id}")
    private ResponseEntity<Object> getBooksByAuthor(@PathVariable("id") Integer authorId) {
        return bookService.getBookByAuthor(authorId);
    }
    @GetMapping("/genre/{id}")
    private ResponseEntity<Object> getBookByGenres(@PathVariable("id") Integer genreId) {
        return bookService.getBookByGenres(genreId);
    }
    @GetMapping("/publisher/{id}")
    private ResponseEntity<Object> getBookByPublisher(@PathVariable("id") Integer publisherId) {
        return bookService.getBookByPublisher(publisherId);
    }
}
