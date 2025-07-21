package com.ecommerce.repository;

import com.ecommerce.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    // Safe method using Spring Data JPA
    User findByUsername(String username);
    
    User findByEmail(String email);
    
    // FIXED: Added JOIN FETCH to solve N+1 query problem
    @Query("SELECT DISTINCT u FROM User u LEFT JOIN FETCH u.orders")
    List<User> findAllWithOrders();
    
    // Removed unsafe SQL injection method - security fix
}