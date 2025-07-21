package com.ecommerce.service;

import com.ecommerce.model.User;
import com.ecommerce.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    // BUG 6: SQL Injection vulnerability - not using parameterized queries
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = '" + username + "'";
        // This would be executed directly - SQL injection risk
        return userRepository.findByUsernameUnsafe(sql);
    }
    
    // BUG 7: Password not hashed
    public User createUser(String username, String email, String password) {
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password); // Storing plain text password
        user.setCreatedAt(new Date());
        
        return userRepository.save(user);
    }
    
    // BUG 8: No input validation
    public User updateUser(Long userId, String username, String email) {
        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            user.setUsername(username); // No validation for null or empty
            user.setEmail(email); // No email format validation
            return userRepository.save(user);
        }
        return null;
    }
    
    // BUG 9: Potential N+1 query problem
    public List<User> getAllUsersWithOrders() {
        List<User> users = userRepository.findAll();
        for (User user : users) {
            // This will trigger additional queries for each user's orders
            user.getOrders().size(); // Force lazy loading
        }
        return users;
    }
    
    // BUG 10: No proper exception handling
    public void deleteUser(Long userId) {
        userRepository.deleteById(userId); // Can throw exception if user doesn't exist
    }
}