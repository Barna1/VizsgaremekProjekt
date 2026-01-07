package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;

import java.util.Date;

@Entity
@Table(name = "basket_product")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class BasketProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "amount")
    @NotNull
    private Integer amount;

    @Column(name = "added_at")
    @NotNull
    private Date addedAt;

    @Column(name = "is_deleted")
    @NotNull
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    @NotNull
    private Date deletedAt;


    @ManyToOne(cascade = {})
    @JoinColumn(name = "basket_id")
    private Basket basket;

    @ManyToOne(cascade = {})
    @JoinColumn(name = "product_id")
    private Book basketBook;

    public BasketProduct(Integer amount, Book book) {
        this.amount = amount;
        this.basketBook = book;
        this.addedAt = new Date();
    }
}
