package com.example.demo.service;

import com.example.demo.entity.Book;
import com.example.demo.entity.Review;
import com.example.demo.entity.User;
import com.example.demo.repository.BookRepository;
import com.example.demo.repository.ReviewRepository;
import com.example.demo.repository.UserRepository;
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
public class ReviewService {
    private final ReviewRepository reviewRepository;
    private final UserRepository userRepository;
    private final BookRepository bookRepository;

    public ResponseEntity<Object> addReview(Review newReview) {
        try {
            if (newReview == null) {
                return ResponseEntity.status(422).build();
            }

            Book searchedBook = bookRepository.getBookById(newReview.getReviewedBook().getId()).orElse(null);
            User author = userRepository.getUserById(newReview.getAuthor().getId()).orElse(null);

            if (searchedBook == null || searchedBook.getIsDeleted()) {
                return ResponseEntity.status(404).body("bookNotFound");
            } else if (author == null || author.getIsDeleted()) {
                return ResponseEntity.status(404).body("authorNotFound");
            }

            if (newReview.getRating() > 5 || newReview.getRating() < 1) {
                return ResponseEntity.status(415).body("invalidRating");
            } else if (newReview.getId() != null) {
                return ResponseEntity.status(415).body("invalidObject");
            }

            return ResponseEntity.ok().body(reviewRepository.save(newReview));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
