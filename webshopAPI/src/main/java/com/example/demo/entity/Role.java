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
@Table(name = "role")
@Getter
@Setter
@NoArgsConstructor
@ToString
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name="name")
    @NotNull
    private String name;

    @Column(name="is_deleted")
    @NotNull
    private Boolean isDeleted;

    @Column(name="deleted_at")
    @NotNull
    private Date deletedAt;

    @OneToMany(mappedBy = "role")
    @JsonIgnore
    private List<User> users;

    public Role(Integer id, String name) {
        this.id = id;
        this.name = name;
    }
}
