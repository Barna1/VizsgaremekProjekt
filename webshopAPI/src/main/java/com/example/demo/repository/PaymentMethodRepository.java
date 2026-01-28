package com.example.demo.repository;

import com.example.demo.entity.PaymentMethod;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface PaymentMethodRepository extends JpaRepository<PaymentMethod, Integer> {
    @Procedure(name = "getPaymentMethodById", procedureName = "getPaymentMethodById")
    Optional<PaymentMethod> getPaymentMethodById(@Param("idIN") Integer id);
}
