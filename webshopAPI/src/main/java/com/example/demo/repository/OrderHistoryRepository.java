package com.example.demo.repository;

import com.example.demo.entity.OrderHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface OrderHistoryRepository extends JpaRepository<OrderHistory, Integer> {
    @Procedure(name = "getOrderHistoryByUserId", procedureName = "getOrderHistoryByUserId")
    List<OrderHistory> getOrderHistoryByUserId(@Param("userIdIN") Integer userId);

    @Procedure(name = "getOrderHistoriesByEmail", procedureName = "getOrderHistoriesByEmail")
    List<OrderHistory> getOrderHistoriesByEmail(@Param("emailIN") String email);

    @Procedure(name = "getOrderHistoryById", procedureName = "getOrderHistoryById")
    Optional<OrderHistory> getOrderHistoryById(@Param("idIN") Integer id);
}
