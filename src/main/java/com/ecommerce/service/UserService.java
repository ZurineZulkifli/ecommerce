package com.ecommerce.service;

import com.ecommerce.model.User;
import com.ecommerce.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.validation.ValidationException;
import java.util.List;
import java.util.Optional;
import java.util.regex.Pattern;

@Service
@Transactional
public class UserService {
    
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    
    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }
    
    // FIXED BUG 6: Using safe repository method instead of SQL injection vulnerable code
    public User findByUsername(String username) {
        if (!StringUtils.hasText(username)) {
            throw new IllegalArgumentException("Username cannot be empty");
        }
        return userRepository.findByUsername(username);
    }
    
    // FIXED BUG 7: Password properly hashed using BCrypt
    public User createUser(String username, String email, String password) {
        validateUserInput(username, email, password);
        
        // Check for existing user
        if (userRepository.findByUsername(username) != null) {
            throw new ValidationException("Username already exists");
        }
        if (userRepository.findByEmail(email) != null) {
            throw new ValidationException("Email already exists");
        }
        
        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim().toLowerCase());
        user.setPasswordHash(passwordEncoder.encode(password)); // Hash the password
        
        return userRepository.save(user);
    }
    
    // FIXED BUG 8: Added proper input validation
    public User updateUser(Long userId, String username, String email) {
        if (userId == null) {
            throw new IllegalArgumentException("User ID cannot be null");
        }
        
        validateUpdateInput(username, email);
        
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isEmpty()) {
            throw new ValidationException("User not found with ID: " + userId);
        }
        
        User user = userOpt.get();
        
        // Check for duplicate username (if different from current)
        if (!user.getUsername().equals(username.trim())) {
            User existingUser = userRepository.findByUsername(username.trim());
            if (existingUser != null) {
                throw new ValidationException("Username already exists");
            }
        }
        
        // Check for duplicate email (if different from current)
        if (!user.getEmail().equals(email.trim().toLowerCase())) {
            User existingUser = userRepository.findByEmail(email.trim().toLowerCase());
            if (existingUser != null) {
                throw new ValidationException("Email already exists");
            }
        }
        
        user.setUsername(username.trim());
        user.setEmail(email.trim().toLowerCase());
        return userRepository.save(user);
    }
    
    // FIXED BUG 9: Using proper JOIN FETCH to avoid N+1 query problem
    @Transactional(readOnly = true)
    public List<User> getAllUsersWithOrders() {
        return userRepository.findAllWithOrders();
    }
    
    // FIXED BUG 10: Proper exception handling
    public boolean deleteUser(Long userId) {
        if (userId == null) {
            throw new IllegalArgumentException("User ID cannot be null");
        }
        
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isEmpty()) {
            return false; // User doesn't exist
        }
        
        try {
            userRepository.deleteById(userId);
            return true;
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete user with ID: " + userId, e);
        }
    }
    
    // Helper methods for validation
    private void validateUserInput(String username, String email, String password) {
        if (!StringUtils.hasText(username) || username.trim().length() < 3) {
            throw new ValidationException("Username must be at least 3 characters long");
        }
        if (!StringUtils.hasText(email) || !EMAIL_PATTERN.matcher(email.trim()).matches()) {
            throw new ValidationException("Invalid email format");
        }
        if (!StringUtils.hasText(password) || password.length() < 8) {
            throw new ValidationException("Password must be at least 8 characters long");
        }
    }
    
    private void validateUpdateInput(String username, String email) {
        if (!StringUtils.hasText(username) || username.trim().length() < 3) {
            throw new ValidationException("Username must be at least 3 characters long");
        }
        if (!StringUtils.hasText(email) || !EMAIL_PATTERN.matcher(email.trim()).matches()) {
            throw new ValidationException("Invalid email format");
        }
    }
    
    public boolean verifyPassword(String rawPassword, String hashedPassword) {
        return passwordEncoder.matches(rawPassword, hashedPassword);
    }
}