package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;

import java.util.Date;

@Entity
@Table(name = "review")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name="review_text")
    @NotNull
    private String reviewText;

    @Column(name="rating")
    @NotNull
    private Float rating;

    @Column(name="is_anonymous")
    @NotNull
    private Boolean isAnonymous;

    @Column(name="is_deleted")
    @NotNull
    private Boolean isDeleted;

    @Column(name="deleted_at")
    @NotNull
    private Date deletedAt;


    @ManyToOne(cascade = {})
    @JoinColumn(name = "product_id")
    private Book reviewedBook;

    @ManyToOne(cascade = {})
    @JoinColumn(name = "user_id")
    private User author;
}
