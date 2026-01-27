package com.example.demo.repository;

import com.example.demo.entity.Publisher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PublisherRepository extends JpaRepository<Publisher, Integer> {
    @Procedure(name = "getPublisherById", procedureName = "getPublisherById")
    Optional<Publisher> getPublisherById(@Param("idIN") Integer id);

    @Procedure(name = "getAllPublisher", procedureName = "getAllPublisher")
    List<Publisher> getAllPublisher();

    @Procedure(name = "deletePublisher", procedureName = "deletePublisher")
    void deletePublisher(@Param("idIN") Integer id);
}
