package com.example.demo.repository;

import com.example.demo.entity.Author;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface AuthorRepository extends JpaRepository<Author, Integer> {
    @Procedure(name = "getAllAuthor", procedureName = "getAllAuthor")
    List<Author> getAllAuthor();

    @Procedure(name = "getAuthorById", procedureName = "getAuthorById")
    Optional<Author> getAuthorById(@Param("idIN") Integer id);

    @Procedure(name = "deleteAuthor", procedureName = "deleteAuthor")
    void deleteAuthor(@Param("idIN") Integer id);
}
