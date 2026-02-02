package com.example.demo.controller;

import com.example.demo.entity.Review;
import com.example.demo.service.ReviewService;
import com.fasterxml.jackson.databind.JsonNode;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/review")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    @PostMapping("")
    private ResponseEntity<Object> addReview(@RequestBody Review newReview) {
        return reviewService.addReview(newReview);
    }
    @PutMapping("")
    private ResponseEntity<Object> updateReview(@RequestBody JsonNode updatedReview) {
        return reviewService.updateReview(updatedReview.get("id").asInt(0), updatedReview.get("reviewText").asText(null));
    }
}
