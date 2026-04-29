package com.example.demo.controller;

import com.example.demo.entity.Book;
import com.example.demo.service.BookService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/book")
public class BookController {
    private final BookService bookService;

    @GetMapping
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
    private ResponseEntity<Object> getBookByGenres(@PathVariable("id") Integer genreId, Pageable pageable) {
        return bookService.getBookByGenres(genreId, pageable);
    }
    @GetMapping("/publisher/{id}")
    private ResponseEntity<Object> getBookByPublisher(@PathVariable("id") Integer publisherId) {
        return bookService.getBookByPublisher(publisherId);
    }

    @PostMapping
    private ResponseEntity<Object> addBook(@RequestBody Book newBook) {
        return bookService.addBook(newBook);
    }
    @GetMapping("/successfully")
    private ResponseEntity<Object> getMostSuccessfullyBooks() {
        return bookService.getMostSuccessfullyBooks();
    }
}
