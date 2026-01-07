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
@Table(name = "author")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Author {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name="first_name")
    @NotNull
    private String firstName;

    @Column(name="middle_name")
    @NotNull
    private String middleName;

    @Column(name="last_name")
    @NotNull
    private String lastName;

    @Column(name="is_deleted")
    @NotNull
    private Boolean isDeleted;

    @Column(name="deleted_at")
    @NotNull
    private Date deletedAt;


    @ManyToMany(fetch = FetchType.LAZY, cascade = {})
    @JoinTable(
            name = "book_author",
            joinColumns = @JoinColumn(name = "author_id"),
            inverseJoinColumns = @JoinColumn(name = "book_id")
    )
    @JsonIgnore
    private List<Book> writtenBooks;
}
