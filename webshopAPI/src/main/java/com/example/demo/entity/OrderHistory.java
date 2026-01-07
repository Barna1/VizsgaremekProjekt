package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;

import java.util.Date;
import java.util.List;

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
    @Null
    private Date canceled_at;

    @Column(name = "is_canceled")
    @NotNull
    @JsonIgnore
    private Boolean isCanceled;

    @Column(name = "canceler_email")
    @Null
    @JsonIgnore
    private String cancelerEmail;

    @Column(name = "canceler_v_code")
    @Null
    @JsonIgnore
    private String cancelerVCode;


    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "billing_detail_id")
    private BillingDetail historyBillingDetail;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "transport_detail_id")
    private TransportDetail historyTransportDetail;

    @ManyToOne(cascade = {})
    @JoinColumn(name = "user_id")
    private User ordererUser;

    @ManyToOne(cascade = {})
    @JoinColumn(name = "payment_method_id")
    private PaymentMethod paymentMethod;

    @ManyToOne(cascade = {})
    @JoinColumn(name = "status_id")
    private Status status;

    @ManyToOne(cascade = {})
    @JoinColumn(name = "canceler_user_id")
    @Null
    private User cancelerUser;

    @OneToMany(
            mappedBy = "history",
            cascade = CascadeType.ALL
    )
    private List<OrderHistoryProduct> orderHistoryProductList;

}
