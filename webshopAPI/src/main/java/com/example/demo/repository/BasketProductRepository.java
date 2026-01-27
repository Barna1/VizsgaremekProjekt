package com.example.demo.repository;

import com.example.demo.entity.BasketProduct;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface BasketProductRepository extends JpaRepository<BasketProduct, Integer> {
    @Procedure(name = "getBasketProductById", procedureName = "getBasketProductById")
    Optional<BasketProduct> getBasketProductById(@Param("idIN") Integer id);

    @Procedure(name = "deleteProductFromBasket", procedureName = "deleteProductFromBasket")
    void deleteProductFromBasket(@Param("idIN") Integer id);
}
