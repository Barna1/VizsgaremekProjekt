package com.example.demo.service;

import com.example.demo.entity.Publisher;
import com.example.demo.repository.PublisherRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
@Transactional
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
    public ResponseEntity<Object> addPublisher(Publisher newPublisher) {
        try {
            if (newPublisher.getId() != null) {
                return ResponseEntity.status(415).body("invalidObject");
            } else if (!isEmailValid(newPublisher.getEmail())) {
                return ResponseEntity.status(415).body("invalidEmail");
            }

            newPublisher.setIsDeleted(false);
            return ResponseEntity.ok().body(publisherRepository.save(newPublisher));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> updatePublisher(Publisher newPublisher) {
        try {
            if (newPublisher.getId() == null) {
                return ResponseEntity.status(415).body("invalidObject");
            } else if (!isEmailValid(newPublisher.getEmail())) {
                return ResponseEntity.status(415).body("invalidEmail");
            }

            newPublisher.setIsDeleted(false);
            return ResponseEntity.ok().body(publisherRepository.save(newPublisher));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    public Boolean isEmailValid(String email) {
        Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
        if (email == null || email.length() > 100) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }
}
