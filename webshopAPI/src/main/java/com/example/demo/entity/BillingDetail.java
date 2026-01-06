package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.antlr.v4.runtime.misc.NotNull;

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
    @NotNull
    private String companyName;

    @Column(name="company_tax_number")
    @NotNull
    private String companyTaxNumber;

    @Column(name="other")
    @NotNull
    private String other;
}
