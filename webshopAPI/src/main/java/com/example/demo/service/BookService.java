package com.example.demo.service;

import com.example.demo.entity.Author;
import com.example.demo.entity.Book;
import com.example.demo.entity.Genre;
import com.example.demo.entity.Publisher;
import com.example.demo.repository.AuthorRepository;
import com.example.demo.repository.BookRepository;
import com.example.demo.repository.GenreRepository;
import com.example.demo.repository.PublisherRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.ConstraintViolationException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Arrays;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class BookService {
    private final BookRepository bookRepository;
    private final AuthorRepository authorRepository;
    private final PublisherRepository publisherRepository;
    private final GenreRepository genreRepository;

    public ResponseEntity<Object> getBooks(Pageable pageable) {
        try {
            Page<Book> returnList = bookRepository.findByIsDeleted(false, pageable);
            HttpHeaders header = new HttpHeaders();
            header.add("TotalPage", returnList.getTotalPages()+"");

            return new ResponseEntity<>(returnList.toList(), header, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> getBookById(Integer id) {
        try {
            if (id == null) {
                return ResponseEntity.status(422).build();
            }

            Book searchedBook = bookRepository.getBookById(id).orElse(null);
            if (searchedBook == null) {
                return ResponseEntity.notFound().build();
            } else {
                return ResponseEntity.ok().body(searchedBook);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> getBookByAuthor(Integer authorId) {
        try {
            if (authorId == null) {
                return ResponseEntity.status(422).build();
            }

            Author searchedAuthor = authorRepository.getAuthorById(authorId).orElse(null);
            if (searchedAuthor == null || searchedAuthor.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            } else {
                List<Integer> bookIds = bookRepository.getAllBookIdByAuthor(authorId);
                return ResponseEntity.ok().body(bookRepository.findAllById(bookIds));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> getBookByGenres(Integer genreId, Pageable pageable) {
        try {
            if (genreId == null) {
                return ResponseEntity.status(422).build();
            }

            Genre searchedGenre = genreRepository.getGenreById(genreId).orElse(null);
            if (searchedGenre == null) {
                return ResponseEntity.notFound().build();
            }

            Page<Book> returnList = bookRepository.findBooksByGenreId(genreId, pageable);
            HttpHeaders header = new HttpHeaders();
            header.add("TotalPage", returnList.getTotalPages()+"");

            return new ResponseEntity<>(returnList.toList(), header, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> getBookByPublisher(Integer publisherId) {
        try {
            if (publisherId == null) {
                return ResponseEntity.status(422).build();
            }
            Publisher searchedPublisher = publisherRepository.getPublisherById(publisherId).orElse(null);
            if (searchedPublisher == null || searchedPublisher.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok().body(searchedPublisher.getBookList().stream().filter(book -> !book.getIsDeleted()).toList());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> addBook(Book newBook) {
        try {
            if (newBook == null) {
                return ResponseEntity.status(422).build();
            }

            Publisher searchedPublisher = publisherRepository.getPublisherById(newBook.getPublisher().getId()).orElse(null);

            if (newBook.getId() != null) {
                return ResponseEntity.status(415).body("invalidObject");
            } else if (searchedPublisher == null || searchedPublisher.getIsDeleted()) {
                return ResponseEntity.status(404).body("publisherNotFound");
            }

            for (Author author : newBook.getAuthors()) {
                Author searchedAuthor = authorRepository.getAuthorById(author.getId()).orElse(null);
                if (searchedAuthor == null || searchedAuthor.getIsDeleted()) {
                    return ResponseEntity.status(404).body("authorNotFound");
                }
            }

            for (Genre genre : newBook.getGenreList()) {
                Genre searchedGenre = genreRepository.getGenreById(genre.getId()).orElse(null);
                if (searchedGenre == null || searchedGenre.getIsDeleted()) {
                    return ResponseEntity.status(404).body("genreNotFound");
                }
            }

            return ResponseEntity.ok().body(bookRepository.save(newBook));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> getMostSuccessfullyBooks() {
        try {
            return ResponseEntity.ok().body(bookRepository.getMostSuccessfullyBooks());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }


//    public Boolean isIsbnValid(String isbnNumber, Integer publisherIsbnSign) {
//        List<String> partsOfIsbnNumber = Arrays.stream(isbnNumber.split("-")).toList();
//        if (partsOfIsbnNumber.size() != 5) {
//            return false;
//        } else if (!partsOfIsbnNumber.get(0).equals("978")) {
//            return false;
//        } else if (!partsOfIsbnNumber.get(3).equals(partsOfIsbnNumber.toString())) {
//            return false;
//        }
//
//        return true;
//    }
}
