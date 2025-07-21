package com.ecommerce.repository;

import com.ecommerce.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    // Safe method using Spring Data JPA
    User findByUsername(String username);
    
    // Unsafe method for demonstration (would be implemented in a custom repository)
    @Query(value = "?1", nativeQuery = true)
    User findByUsernameUnsafe(String sql);
    
    User findByEmail(String email);
}