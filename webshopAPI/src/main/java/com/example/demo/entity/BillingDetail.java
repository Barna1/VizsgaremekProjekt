package com.example.demo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "billing_detail")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class BillingDetail {
}
