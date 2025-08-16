package com.novaix.govconnect_server.service.user.impl;

import com.novaix.govconnect_server.dao.UsersDao;
import com.novaix.govconnect_server.exception.custom.ForbiddenException;
import com.novaix.govconnect_server.exception.custom.InvalidInputException;
import com.novaix.govconnect_server.exception.custom.ResourceNotFoundException;
import com.novaix.govconnect_server.repository.UserRepository;
import com.novaix.govconnect_server.request.UserUpdateRequest;
import com.novaix.govconnect_server.response.UserUpdateResponse;
import com.novaix.govconnect_server.service.user.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class UserServiceImpl implements UserService {

    private static final String PHONE_NUMBER_PATTERN = "\\d{10}";

    private final UserRepository userRepository;
    private final ModelMapper modelMapper;

    @Override
    public UserUpdateResponse updateUser(Long userId, UserUpdateRequest request, String authenticatedUserEmail) {
        log.info("Attempting to update user with ID: {} by authenticated user: {}", userId, authenticatedUserEmail);
        
        // Find the user to be updated
        Optional<UsersDao> userOptional = userRepository.findById(userId);
        if (userOptional.isEmpty()) {
            log.error("User not found with ID: {}", userId);
            throw new ResourceNotFoundException("User not found with ID: " + userId);
        }
        
        UsersDao userToUpdate = userOptional.get();
        
        // Security check: Only allow users to update their own profile
        if (!userToUpdate.getEmail().equals(authenticatedUserEmail)) {
            log.error("User {} attempted to update user {} profile. Access denied.", 
                     authenticatedUserEmail, userToUpdate.getEmail());
            throw new ForbiddenException("You can only update your own profile");
        }
        
        // Validate phone number format if provided
        if (request.getPhoneNumber() != null && !request.getPhoneNumber().matches(PHONE_NUMBER_PATTERN)) {
            throw new InvalidInputException("Phone number must be 10 digits long");
        }
        
        // Validate date of birth if provided
        if (request.getDob() != null) {
            if (request.getDob().isAfter(LocalDate.now().minusYears(18))) {
                throw new InvalidInputException("You must be at least 18 years old");
            }
        }
        
        // Update allowed fields only
        if (request.getFirstName() != null && !request.getFirstName().trim().isEmpty()) {
            userToUpdate.setFirstname(request.getFirstName().trim());
        }
        
        if (request.getLastName() != null && !request.getLastName().trim().isEmpty()) {
            userToUpdate.setLastname(request.getLastName().trim());
        }
        
        if (request.getPhoneNumber() != null && !request.getPhoneNumber().trim().isEmpty()) {
            userToUpdate.setContact(request.getPhoneNumber().trim());
        }
        
        if (request.getAddress() != null) {
            userToUpdate.setAddress(request.getAddress());
        }
        
        if (request.getDob() != null) {
            userToUpdate.setDob(request.getDob());
        }
        
        // Save updated user
        UsersDao updatedUser = userRepository.save(userToUpdate);
        log.info("Successfully updated user with ID: {}", userId);
        
        // Map to response DTO
        UserUpdateResponse response = modelMapper.map(updatedUser, UserUpdateResponse.class);
        
        // Ensure correct field mapping from entity to response
        response.setPhoneNumber(updatedUser.getContact());
        response.setFirstName(updatedUser.getFirstname());
        response.setLastName(updatedUser.getLastname());
        
        return response;
    }
}
