package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import javax.validation.constraints.Size;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "book")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "title")
    @NotNull
    private String title;

    @Column(name = "description")
    @NotNull
    private String description;

    @Column(name = "cover_image_path")
    @NotNull
    private String coverImgPath = "";

    @Column(name = "publishing_year")
    @NotNull
    @Size(max=4)
    private Integer publishingYear;

    @Column(name = "ISBN")
    @NotNull
    private String ISBN;

    @Column(name = "price")
    @NotNull
    private Integer price;

    @Column(name = "stock_quantity")
    @NotNull
    private Integer stockQuantity;

    @Column(name = "is_deleted")
    @Null
    @JsonIgnore
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    @Null
    @JsonIgnore
    private Date deletedAt;


    @ManyToMany(fetch = FetchType.LAZY, cascade = {}, mappedBy = "writtenBooks")
    private List<Author> authors;

    @JsonIgnore
    @OneToMany(
            mappedBy = "basketBook",
            fetch = FetchType.LAZY,
            cascade = {}
    )
    private List<BasketProduct> basketProducts;

    @ManyToOne()
    @JoinColumn(name = "publisher_id")
    private Publisher publisher;


    @ManyToMany(fetch = FetchType.LAZY, cascade = {}, mappedBy = "bookList")
    private List<Genre> genreList;

    @OneToMany(fetch = FetchType.LAZY, cascade = {}, mappedBy = "reviewedBook")
    private List<Review> reviewList;

    @OneToMany(
            mappedBy = "orderHistoryBook",
            cascade = {}
    )
    private List<OrderHistoryProduct> orderHistoryProductList;
}
