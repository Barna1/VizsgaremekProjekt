package com.example.demo.controller;

import com.example.demo.entity.Review;
import com.example.demo.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/review")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    @PostMapping("")
    private ResponseEntity<Object> addReview(@RequestBody Review newReview) {
        return reviewService.addReview(newReview);
    }
}
