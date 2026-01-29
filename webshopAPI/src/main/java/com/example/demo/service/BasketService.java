package com.example.demo.service;

import com.example.demo.entity.Basket;
import com.example.demo.entity.BasketProduct;
import com.example.demo.entity.User;
import com.example.demo.repository.BasketProductRepository;
import com.example.demo.repository.BasketRepository;
import com.example.demo.repository.BookRepository;
import com.example.demo.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.ConstraintViolationException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

@Service
@RequiredArgsConstructor
@Transactional(noRollbackFor = {DataIntegrityViolationException.class, ConstraintViolationException.class, SQLIntegrityConstraintViolationException.class, SQLException.class})
public class BasketService {
    private final UserRepository userRepository;
    private final BasketRepository basketRepository;
    private final BasketProductRepository basketProductRepository;
    private final BookRepository bookRepository;

    public ResponseEntity<Object> getBasketByUserId(Integer userId) {
        try {
            if (userId == null) {
                return ResponseEntity.status(422).build();
            }

            User searchedUser = userRepository.getUserById(userId).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }

            Basket basket = basketRepository.getBasketByUserId(userId).orElse(null);
            basket.setProductList(basket.getProductList().stream().filter(product -> !product.getIsDeleted()).toList());
            return ResponseEntity.ok().body(basket);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> deleteProductFromBasket(Integer basketProductId, Integer basketId) {
        try {
            if (basketProductId == null || basketId == null) {
                return ResponseEntity.status(422).build();
            }

            Basket searchedBasket = basketRepository.getBasketById(basketId).orElse(null);
            if (searchedBasket == null) {
                return ResponseEntity.status(404).body("basketNotFound");
            }
            BasketProduct searchedProduct = basketProductRepository.getBasketProductById(basketProductId).orElse(null);
            if (searchedProduct == null || searchedProduct.getIsDeleted()) {
                return ResponseEntity.status(404).body("productNotFound");
            }

            basketProductRepository.deleteProductFromBasket(searchedProduct.getId());
            searchedProduct.getBasketBook().setStockQuantity(searchedProduct.getBasketBook().getStockQuantity() + searchedProduct.getAmount());
            bookRepository.save(searchedProduct.getBasketBook());

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
