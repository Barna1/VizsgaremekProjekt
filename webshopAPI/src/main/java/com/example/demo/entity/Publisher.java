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
@Table(name = "publisher")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Publisher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name="name")
    @NotNull
    private String Name;

    @Column(name="email")
    @NotNull
    private String email;

    @Column(name="phone")
    @NotNull
    private String phone;

    @Column(name = "isbn_sign")
    @NotNull
    private Integer isbnSign;

    @Column(name = "is_deleted")
    @JsonIgnore
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    @JsonIgnore
    private Date deletedAt;
}
