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
@Table(name = "address_type")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class AddressType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name="name")
    @NotNull
    private String name;


    @JsonIgnore
    @OneToMany(
            fetch = FetchType.LAZY,
            cascade = {}
    )
    private List<BillingDetail> billingDetailList;

    @JsonIgnore
    @OneToMany(
            mappedBy = "transportDetailAddressType",
            cascade = {}
    )
    private List<TransportDetail> transportDetails;
}
