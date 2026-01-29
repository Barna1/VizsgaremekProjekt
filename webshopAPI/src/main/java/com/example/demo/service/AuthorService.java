package com.example.demo.service;

import com.example.demo.entity.Author;
import com.example.demo.repository.AuthorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.ConstraintViolationException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

@Service
@RequiredArgsConstructor
@Transactional(noRollbackFor = {DataIntegrityViolationException.class, ConstraintViolationException.class, SQLIntegrityConstraintViolationException.class, SQLException.class})

public class AuthorService {
    private final AuthorRepository authorRepository;

    public ResponseEntity<Object> getAllAuthor() {
        try {
            return ResponseEntity.ok().body(authorRepository.getAllAuthor());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> addAuthor(Author newAuthor) {
        try {
            if (newAuthor == null) {
                return ResponseEntity.status(422).build();
            }

            if (newAuthor.getId() != null) {
                return ResponseEntity.status(415).build();
            } else {
                return ResponseEntity.ok().body(authorRepository.save(newAuthor));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> deleteAuthor(Integer id) {
        try {
            if (id == null) {
                return ResponseEntity.status(422).build();
            }

            authorRepository.deleteAuthor(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
