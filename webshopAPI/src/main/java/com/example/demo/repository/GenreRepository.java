package com.example.demo.repository;

import com.example.demo.entity.Genre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface GenreRepository extends JpaRepository<Genre, Integer> {
    @Procedure(name = "getAllGenre", procedureName = "getAllGenre")
    List<Genre> getAllGenre();

    @Procedure(name = "deleteGenre", procedureName = "deleteGenre")
    void deleteGenre(@Param("idIN") Integer id);

    @Procedure(name = "getGenreById", procedureName = "getGenreById")
    Optional<Genre> getGenreById(@Param("idIN") Integer id);
}
