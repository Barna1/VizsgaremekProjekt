package com.example.demo.service;

import com.example.demo.entity.Publisher;
import com.example.demo.repository.PublisherRepository;
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
public class PublisherService {
    private final PublisherRepository publisherRepository;
    public ResponseEntity<Object> getAllPublisher() {
        try {
            return ResponseEntity.ok().body(publisherRepository.getAllPublisher());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> deletePublisherById(Integer id) {
        try {
            if (id == null) {
                return ResponseEntity.status(422).build();
            }
            Publisher searchedPublisher = publisherRepository.getPublisherById(id).orElse(null);
            if (searchedPublisher == null || searchedPublisher.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            } else {
                publisherRepository.deletePublisher(id);
                return ResponseEntity.ok().build();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> getPublisherById(Integer id) {
        try {
            Publisher searchedPublisher = publisherRepository.findById(id).orElse(null);
            if (searchedPublisher == null || searchedPublisher.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            } else {
                return ResponseEntity.ok(searchedPublisher);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
