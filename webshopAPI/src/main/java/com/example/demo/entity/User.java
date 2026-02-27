package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "user")
@Getter
@Setter
@NoArgsConstructor
@ToString
@NamedStoredProcedureQueries({
        @NamedStoredProcedureQuery(name = "getUserByUsername", procedureName = "getUserByUsername", parameters = {
                @StoredProcedureParameter(name = "usernameIN", type = String.class, mode = ParameterMode.IN)
        }, resultClasses = User.class),
        @NamedStoredProcedureQuery(name = "getUserById", procedureName = "getUserById", parameters = {
                @StoredProcedureParameter(name = "idIN", type = Integer.class, mode = ParameterMode.IN)
        }, resultClasses = User.class),
        @NamedStoredProcedureQuery(name = "getUserByEmail", procedureName = "getUserByEmail", parameters = {
                @StoredProcedureParameter(name = "emailIN", type = String.class, mode = ParameterMode.IN)
        }, resultClasses = User.class),

        @NamedStoredProcedureQuery(name = "deleteUserById", procedureName = "deleteUserById", parameters = {
                @StoredProcedureParameter(name = "idIN", type = String.class, mode = ParameterMode.IN)
        }),
})
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "username")
    @NotNull
    private String username;

    @Column(name = "email")
    @NotNull
    private String email;

    @Column(name = "password")
    @NotNull
    private String password;

    @Column(name = "pfp_path")
    @NotNull
    private String pfpPath = "default";

    @Column(name = "last_login")
    @NotNull
    private Date lastLogin;

    @Column(name = "register_at")
    @NotNull
    private Date registerAt;

    @Column(name = "is_deleted")
    @NotNull
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    @NotNull
    private Date deletedAt;

    @Column(name = "v_code")
    @NotNull
    private String vCode;


    @OneToOne(mappedBy = "basketUser", cascade = {CascadeType.ALL})
    @JsonIgnoreProperties({"basketUser", "productList"})
    private Basket basket;

    @OneToMany(mappedBy = "author", cascade = {})
    @JsonIgnore
    private List<Review> writtenReviews;

    @JsonIgnore
    @OneToMany(mappedBy = "ordererUser")
    private List<OrderHistory> orderHistoryList;

    @JsonIgnore
    @OneToMany(mappedBy = "cancelerUser")
    private List<OrderHistory> canceledOrderHistoryList;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;
}
