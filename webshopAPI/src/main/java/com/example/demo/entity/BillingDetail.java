package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;

@Entity
@Table(name = "billing_detail")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class BillingDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name="post_code")
    @NotNull
    private Integer postCode;

    @Column(name="town")
    @NotNull
    private String town;

    @Column(name="address")
    @NotNull
    private String address;

    @Column(name="house_number")
    @NotNull
    private Integer houseNumber;

    @Column(name="company_name")
    @Null
    private String companyName;

    @Column(name="company_tax_number")
    @Null
    private String companyTaxNumber;

    @Column(name="other")
    @Null
    private String other;


    @ManyToOne(cascade = {})
    @JoinColumn(name = "address_type_id")
    @Null
    private AddressType billingDetailsAddressType;

    @OneToOne(mappedBy = "historyBillingDetail")
    private OrderHistory history;
}
