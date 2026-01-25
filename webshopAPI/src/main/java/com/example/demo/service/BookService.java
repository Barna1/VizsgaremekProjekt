package com.example.demo.service;

import com.example.demo.entity.Book;
import com.example.demo.repository.BookRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BookService {
    private final BookRepository bookRepository;
    public ResponseEntity<Object> getBooks(Pageable pageable) {
        try {
            Page<Book> returnList = bookRepository.findByIsDeleted(false, pageable);
            HttpHeaders header = new HttpHeaders();
            header.add("TotalPage", returnList.getTotalPages()+"");

            return new ResponseEntity<>(returnList.toList(), header, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
