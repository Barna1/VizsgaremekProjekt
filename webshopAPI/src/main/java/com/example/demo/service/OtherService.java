package com.example.demo.service;

import com.example.demo.repository.AddressTypeRepository;
import com.example.demo.repository.PaymentMethodRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OtherService {

    private final PaymentMethodRepository paymentMethodRepository;
    private final AddressTypeRepository addressTypeRepository;

    public ResponseEntity<Object> getAllPaymentMethod() {
        try {
            return ResponseEntity.ok().body(paymentMethodRepository.findAll());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> getAllAddressType() {
        try {
            return ResponseEntity.ok().body(addressTypeRepository.findAll());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
