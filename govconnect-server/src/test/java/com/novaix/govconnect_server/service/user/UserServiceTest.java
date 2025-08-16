package com.novaix.govconnect_server.service.user;

import com.novaix.govconnect_server.common.Address;
import com.novaix.govconnect_server.dao.UsersDao;
import com.novaix.govconnect_server.enums.Gender;
import com.novaix.govconnect_server.enums.Role;
import com.novaix.govconnect_server.exception.custom.ForbiddenException;
import com.novaix.govconnect_server.exception.custom.ResourceNotFoundException;
import com.novaix.govconnect_server.repository.UserRepository;
import com.novaix.govconnect_server.request.UserUpdateRequest;
import com.novaix.govconnect_server.response.UserUpdateResponse;
import com.novaix.govconnect_server.service.user.impl.UserServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.modelmapper.ModelMapper;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private ModelMapper modelMapper;

    @InjectMocks
    private UserServiceImpl userService;

    private UsersDao testUser;
    private UserUpdateRequest updateRequest;
    private UserUpdateResponse updateResponse;

    @BeforeEach
    void setUp() {
        testUser = new UsersDao();
        testUser.setId(1L);
        testUser.setFirstname("John");
        testUser.setLastname("Doe");
        testUser.setEmail("john.doe@example.com");
        testUser.setContact("1234567890");
        testUser.setPassword("hashedPassword");
        testUser.setDob(LocalDate.of(1990, 1, 1));
        testUser.setGender(Gender.MALE);
        testUser.setNic("123456789V");
        testUser.setRole(Role.ROLE_USER);
        
        Address address = new Address("Colombo", "Mount Lavinia", "Western", "123 Main St");
        testUser.setAddress(address);

        updateRequest = new UserUpdateRequest();
        updateRequest.setFirstName("Jane");
        updateRequest.setLastName("Smith");
        updateRequest.setPhoneNumber("0987654321");
        updateRequest.setDob(LocalDate.of(1992, 6, 15));
        
        Address newAddress = new Address("Kandy", "Peradeniya", "Central", "456 New St");
        updateRequest.setAddress(newAddress);

        updateResponse = new UserUpdateResponse();
        updateResponse.setId(1L);
        updateResponse.setFirstName("Jane");
        updateResponse.setLastName("Smith");
        updateResponse.setPhoneNumber("0987654321");
        updateResponse.setEmail("john.doe@example.com");
        updateResponse.setAddress(newAddress);
        updateResponse.setDob(updateRequest.getDob());
        updateResponse.setGender(Gender.MALE);
        updateResponse.setNic("123456789V");
        updateResponse.setRole(Role.ROLE_USER);
        updateResponse.setUpdatedAt(LocalDateTime.now());
    }

    @Test
    void testUpdateUser_Success() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser));
        when(userRepository.save(any(UsersDao.class))).thenReturn(testUser);
        when(modelMapper.map(any(UsersDao.class), eq(UserUpdateResponse.class))).thenReturn(updateResponse);

        UserUpdateResponse result = userService.updateUser(1L, updateRequest, "john.doe@example.com");

        assertNotNull(result);
        assertEquals("Jane", result.getFirstName());
        assertEquals("Smith", result.getLastName());
        assertEquals("0987654321", result.getPhoneNumber());
        
        verify(userRepository).findById(1L);
        verify(userRepository).save(any(UsersDao.class));
        verify(modelMapper).map(any(UsersDao.class), eq(UserUpdateResponse.class));
    }

    @Test
    void testUpdateUser_UserNotFound() {
        when(userRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> {
            userService.updateUser(1L, updateRequest, "john.doe@example.com");
        });
        
        verify(userRepository).findById(1L);
        verify(userRepository, never()).save(any(UsersDao.class));
    }

    @Test
    void testUpdateUser_ForbiddenAccess() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser));

        assertThrows(ForbiddenException.class, () -> {
            userService.updateUser(1L, updateRequest, "different.user@example.com");
        });
        
        verify(userRepository).findById(1L);
        verify(userRepository, never()).save(any(UsersDao.class));
    }

    @Test
    void testUpdateUser_InvalidPhoneNumber() {
        updateRequest.setPhoneNumber("invalid");
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser));

        assertThrows(com.novaix.govconnect_server.exception.custom.InvalidInputException.class, () -> {
            userService.updateUser(1L, updateRequest, "john.doe@example.com");
        });
        
        verify(userRepository).findById(1L);
        verify(userRepository, never()).save(any(UsersDao.class));
    }

    @Test
    void testUpdateUser_WithDateOfBirth() {
        LocalDate newDob = LocalDate.of(1995, 12, 25);
        updateRequest.setDob(newDob);
        
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser));
        when(userRepository.save(any(UsersDao.class))).thenReturn(testUser);
        when(modelMapper.map(any(UsersDao.class), eq(UserUpdateResponse.class))).thenReturn(updateResponse);

        UserUpdateResponse result = userService.updateUser(1L, updateRequest, "john.doe@example.com");

        assertNotNull(result);
        verify(userRepository).findById(1L);
        verify(userRepository).save(any(UsersDao.class));
        verify(modelMapper).map(any(UsersDao.class), eq(UserUpdateResponse.class));
    }

    @Test
    void testUpdateUser_InvalidDateOfBirth_TooYoung() {
        LocalDate invalidDob = LocalDate.now().minusYears(17);
        updateRequest.setDob(invalidDob);
        when(userRepository.findById(1L)).thenReturn(Optional.of(testUser));

        assertThrows(com.novaix.govconnect_server.exception.custom.InvalidInputException.class, () -> {
            userService.updateUser(1L, updateRequest, "john.doe@example.com");
        });
        
        verify(userRepository).findById(1L);
        verify(userRepository, never()).save(any(UsersDao.class));
    }
}
