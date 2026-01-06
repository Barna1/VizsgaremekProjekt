package com.example.demo.repository;

import com.example.demo.entity.OrderHistoryProduct;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderHistoryProductRepository extends JpaRepository<OrderHistoryProduct, Integer> {
}
