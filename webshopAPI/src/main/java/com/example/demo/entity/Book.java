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
}
