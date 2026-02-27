package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;
import java.util.List;

@Entity
@Table(name = "payment_method")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class PaymentMethod {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name="name")
    @NotNull
    private String name;


    @JsonIgnore
    @OneToMany(mappedBy = "paymentMethod")
    private List<OrderHistory> orderHistoryList;
}
