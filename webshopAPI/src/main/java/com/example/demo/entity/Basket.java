package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "basket")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Basket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "last_modified")
    @NotNull
    private String lastModified;

    @Column(name = "total_price")
    @NotNull
    private String totalPrice;

    @Column(name = "is_deleted")
    @NotNull
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    @NotNull
    private Date deletedAt;


    @OneToOne(cascade = {CascadeType.ALL})
    @JoinColumn(name = "user_id")
    private User basketUser;

    @JsonIgnore
    @OneToMany(
            mappedBy = "basket",
            fetch = FetchType.LAZY,
            cascade = {CascadeType.REFRESH, CascadeType.MERGE}
    )
    private List<BasketProduct> productList;
}
