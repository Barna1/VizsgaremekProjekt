package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.antlr.v4.runtime.misc.NotNull;

import java.util.Date;

@Entity
@Table(name = "order_history")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class OrderHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "first_name")
    @NotNull
    private String firstName;

    @Column(name = "last_name")
    @NotNull
    private String lastName;

    @Column(name = "phone")
    @NotNull
    private String phone;

    @Column(name = "email")
    @NotNull
    private String email;

    @Column(name = "is_deleted")
    @NotNull
    private Boolean isDeleted;

    @Column(name = "ordered_at")
    @NotNull
    private Date orderedAt;

    @Column(name = "canceled_at")
    @NotNull
    private Date canceled_at;

    @Column(name = "is_canceled")
    @NotNull
    @JsonIgnore
    private Boolean isCanceled;

    @Column(name = "canceler_email")
    @NotNull
    @JsonIgnore
    private String cancelerEmail;

    @Column(name = "canceler_v_code")
    @NotNull
    @JsonIgnore
    private String cancelerVCode;
}
