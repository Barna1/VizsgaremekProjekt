package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import javax.validation.constraints.NotNull;

import java.util.Date;

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
}
