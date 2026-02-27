package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "order_history_product")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class OrderHistoryProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name="amount")
    @NotNull
    private Integer amount;


    @ManyToOne
    @JoinColumn(name = "order_history_id")
    @JsonIgnore
    private OrderHistory history;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Book orderHistoryBook;

    public OrderHistoryProduct(Integer amount, Book orderHistoryBook) {
        this.amount = amount;
        this.orderHistoryBook = orderHistoryBook;
    }
}
