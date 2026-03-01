package com.example.demo.controller;

import com.example.demo.entity.Publisher;
import com.example.demo.service.PublisherService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/publisher")
@RequiredArgsConstructor
public class PublisherController {

    private final PublisherService publisherService;

    @GetMapping
    private ResponseEntity<Object> getAllPublisher() {
        return publisherService.getAllPublisher();
    }
    @DeleteMapping("/{id}")
    private ResponseEntity<Object> deletePublisherById(@PathVariable("id") Integer id) {
        return publisherService.deletePublisherById(id);
    }
    @GetMapping("/{id}")
    private ResponseEntity<Object> getPublisherById(@PathVariable("id") Integer id) {
        return publisherService.getPublisherById(id);
    }

    @PostMapping
    private ResponseEntity<Object> addPublisher(@RequestBody Publisher newPublisher) {
        return publisherService.addPublisher(newPublisher);
    }

    @PutMapping
    private ResponseEntity<Object> updatePublisher(@RequestBody Publisher updatedPublisher) {
        return publisherService.updatePublisher(updatedPublisher);
    }
}
