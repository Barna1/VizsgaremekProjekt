package com.example.demo.service;

import com.example.demo.entity.Genre;
import com.example.demo.repository.GenreRepository;
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
public class GenreService {
    private final GenreRepository genreRepository;

    public ResponseEntity<Object> getAllGenre() {
        try {
            return ResponseEntity.ok().body(genreRepository.getAllGenre());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> addGenre(Genre newGenre) {
        try {
            if (newGenre == null) {
                return ResponseEntity.status(422).build();
            }

            if (newGenre.getId() != null) {
                return ResponseEntity.status(415).body("invalidObject");
            } else {
                return ResponseEntity.ok().body(genreRepository.save(newGenre));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> updateGenre(Genre updatedGenre) {
        try {
            if (updatedGenre == null) {
                return ResponseEntity.status(422).build();
            }

            if (updatedGenre.getId() == null) {
                return ResponseEntity.status(415).build();
            } else {
                return ResponseEntity.ok().body(genreRepository.save(updatedGenre));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
