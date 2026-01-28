package com.example.demo.repository;

import com.example.demo.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface ReviewRepository extends JpaRepository<Review, Integer> {
    @Procedure(name = "deleteReviewById", procedureName = "deleteReviewById")
    void deleteReviewById(@Param("idIN") Integer id);

    @Procedure(name = "getReviewById", procedureName = "getReviewById")
    Optional<Review> getReviewById(@Param("idIN") Integer id);
}
