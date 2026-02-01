package com.example.demo.service;

import com.example.demo.config.email.EmailSender;
import com.example.demo.entity.*;
import com.example.demo.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.ConstraintViolationException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(noRollbackFor = {DataIntegrityViolationException.class, ConstraintViolationException.class, SQLIntegrityConstraintViolationException.class, SQLException.class})
public class OrderService {
    private final OrderHistoryRepository orderHistoryRepository;
    private final UserRepository userRepository;
    private final StatusRepository statusRepository;
    private final EmailSender emailSender;
    private final PasswordEncoder passwordEncoder;
    private final BookRepository bookRepository;
    private final AddressTypeRepository addressTypeRepository;

    public ResponseEntity<Object> getOrderHistoryByUserId(Integer userId) {
        try {
            if (userId == null) {
                return ResponseEntity.status(422).build();
            }
            User searchedUser = userRepository.getUserById(userId).orElse(null);
            if (searchedUser == null || searchedUser.getIsDeleted()) {
                return ResponseEntity.notFound().build();
            }

            return ResponseEntity.ok().body(orderHistoryRepository.getOrderHistoryByUserId(userId));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> cancelOrder(Integer orderId, Integer cancelerUserId) {
        try {
            if (orderId == null) {
                return ResponseEntity.status(422).build();
            }
            OrderHistory searchedOrderHistory = orderHistoryRepository.getOrderHistoryById(orderId).orElse(null);
            if (searchedOrderHistory == null || searchedOrderHistory.getIsCanceled()) {
                return ResponseEntity.status(404).body("orderNotFound");
            }
            if (cancelerUserId != 0) {
                User cancelerUser = userRepository.getUserById(cancelerUserId).orElse(null);
                if (cancelerUser == null || cancelerUser.getIsDeleted()) {
                    return ResponseEntity.status(404).body("userNotFound");
                }
                searchedOrderHistory.setCancelerUser(cancelerUser);
            } else {
                searchedOrderHistory.setCancelerEmail(searchedOrderHistory.getEmail());
            }

            try {
                emailSender.sendEmailAboutCancelledOrder(searchedOrderHistory.getEmail());
            } catch (Exception e) {
                return ResponseEntity.internalServerError().body("emailSenderError");
            }

            searchedOrderHistory.setStatus(statusRepository.findById(3).get());
            searchedOrderHistory.setCanceled_at(new Date());
            searchedOrderHistory.setIsCanceled(true);
            orderHistoryRepository.save(searchedOrderHistory);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> getOrderHistoryByVCode(String email, String vCode) {
        try {
            if (email == null || vCode == null) {
                return ResponseEntity.status(422).build();
            }

            List<OrderHistory> histories = orderHistoryRepository.getOrderHistoriesByEmail(email);
            for (int i = 0; i < histories.size(); i++) {
                if (passwordEncoder.matches(vCode, histories.get(i).getCancelerVCode())) {
                    return ResponseEntity.ok().body(histories.get(i));
                }
            }
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> getAllOrder() {
        try {
            return ResponseEntity.ok().body(orderHistoryRepository.findAll());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
    public ResponseEntity<Object> sendOrder(OrderHistory newOrder, Integer basketId) {
        try {
            if (newOrder == null || basketId == null) {
                return ResponseEntity.status(422).build();
            }

            if (newOrder.getOrdererUser() != null) {
                User searchedUser = userRepository.getUserById(newOrder.getOrdererUser().getId()).orElse(null);
                if (searchedUser == null || searchedUser.getIsDeleted()) {
                    return ResponseEntity.status(404).body("userNotFound");
                }
            }

            PaymentMethod searchedPaymentMethod = paymentMethodRepository.getPaymentMethodById(newOrder.getPaymentMethod().getId()).orElse(null);
            Basket searchedBasket = basketRepository.getBasketById(basketId).orElse(null);

            if (searchedPaymentMethod == null) {
                return ResponseEntity.status(404).body("paymentMethodNotFound");
            } else if (searchedBasket == null) {
                return ResponseEntity.status(404).body("basketNotFound");
            }

            if (newOrder.getId() != null) {
                return ResponseEntity.status(415).body("invalidObject");
            } else if (!isEmailValid(newOrder.getEmail().trim())) {
                return ResponseEntity.status(415).body("invalidEmail");
            } else if (!isPhoneValid(newOrder.getPhone())) {
                return ResponseEntity.status(415).body("invalidPhone");
            } else if (!isBillingDetailValid(newOrder.getHistoryBillingDetail())) {
                return ResponseEntity.status(415).body("invalidBillingDetails");
            } else if (!isTransportDetailValid(newOrder.getHistoryTransportDetail())) {
                return ResponseEntity.status(415).body("invalidBillingDetails");
            }

            int sumPrice = 0;
            List<OrderHistoryProduct> orderedProductList = new ArrayList<>();
            for (int i = 0; i < searchedBasket.getProductList().size(); i++) {
                BasketProduct productFromBasket = searchedBasket.getProductList().get(i);
                Book book = productFromBasket.getBasketBook();
                book.setStockQuantity(book.getStockQuantity() - productFromBasket.getAmount());

                orderedProductList.add(new OrderHistoryProduct(productFromBasket.getAmount(), book));
                bookRepository.save(book);
                sumPrice += (book.getPrice() * productFromBasket.getAmount());
            }

            try {
                emailSender.sendEmailAboutOrderWithVCode(newOrder.getEmail(), generateVCode());
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.internalServerError().body("emailSenderError");
            }

            System.out.println(sumPrice);

            newOrder.setOrderHistoryProductList(orderedProductList);
            newOrder.setStatus(statusRepository.findById(1).get());
            orderHistoryRepository.save(newOrder);

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }


    public Boolean isBillingDetailValid(BillingDetail billingDetail) {
        if (billingDetail.getId() != null) {
            return false;
        }
        AddressType searchedAddressType = addressTypeRepository.getAddressTypeById(billingDetail.getBillingDetailsAddressType().getId()).orElse(null);
        if (searchedAddressType == null) {
            return false;
        } else if (!isValidAddress(billingDetail.getPostCode(), billingDetail.getTown())) {
            return false;
        }
        if (billingDetail.getCompanyTaxNumber() != null) {
            if (!isValidTaxNumber(billingDetail.getCompanyTaxNumber())) {
                return false;
            }
        }

        return true;
    }
}
