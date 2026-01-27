package com.example.demo.repository;

import com.example.demo.entity.AddressType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface AddressTypeRepository extends JpaRepository<AddressType, Integer> {
    @Procedure(name = "getAddressTypeById", procedureName = "getAddressTypeById")
    Optional<AddressType> getAddressTypeById(@Param("idIN") Integer id);
}
