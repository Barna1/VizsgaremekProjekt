package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import java.util.Date;
import java.util.List;

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
    private String name;

    @Column(name="email")
    @NotNull
    private String email;

    @Column(name="phone")
    @NotNull
    private String phone;

    @Column(name = "isbn_sign")
    @NotNull
    @Size(max=5)
    private String isbnSign;

    @Column(name = "is_deleted")
    @JsonIgnore
    private Boolean isDeleted;

    @Column(name = "deleted_at")
    @JsonIgnore
    private Date deletedAt;

    @OneToMany(mappedBy = "publisher")
    @JsonIgnore
    private List<Book> bookList;
}
