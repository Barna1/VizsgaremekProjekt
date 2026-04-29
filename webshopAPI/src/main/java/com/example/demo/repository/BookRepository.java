package com.example.demo.repository;

import com.example.demo.entity.Author;
import com.example.demo.entity.Book;
import com.example.demo.entity.Genre;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface BookRepository extends JpaRepository<Book, Integer> {
    @Procedure(name = "getBookById", procedureName = "getBookById")
    Optional<Book> getBookById(@Param("idIN") Integer id);

    @Procedure(name = "getMostSuccessfullyBooks", procedureName = "getMostSuccessfullyBooks")
    List<Book> getMostSuccessfullyBooks();

    @Procedure(name = "deleteBookById", procedureName = "deleteBookById")
    void deleteBookById(@Param("idIN") Integer id);

    @Procedure(name = "getAllBookIdByAuthor", procedureName = "getAllBookIdByAuthor")
    List<Integer> getAllBookIdByAuthor(@Param("authorIdIN") Integer authorId);

    Page<Book> findByIsDeleted(Boolean isDeleted, Pageable pageable);

    @Query(
            value = "SELECT b FROM Book b JOIN b.genreList g WHERE g.id = :genreId AND b.isDeleted = false",
            countQuery = "SELECT COUNT(b) FROM Book b JOIN b.genreList g WHERE g.id = :genreId AND b.isDeleted = false"
    )
    Page<Book> findBooksByGenreId(@Param("genreId") Integer genreId, Pageable pageable);
}
