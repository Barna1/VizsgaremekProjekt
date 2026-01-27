package com.example.demo.repository;

import com.example.demo.entity.Basket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface BasketRepository extends JpaRepository<Basket, Integer> {
    @Procedure(name = "getBasketByUserId", procedureName = "getBasketByUserId")
    Optional<Basket> getBasketByUserId(@Param("userIdIN") Integer userId);

    @Procedure(name = "getBasketById", procedureName = "getBasketById")
    Optional<Basket> getBasketById(@Param("idIN") Integer basketId);

    @Procedure(name = "clearBasket", procedureName = "clearBasket")
    void clearBasket(@Param("idIN") Integer basketId);
}
