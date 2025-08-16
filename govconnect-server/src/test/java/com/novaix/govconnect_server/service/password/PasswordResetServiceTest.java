package com.novaix.govconnect_server.service.password;

import java.time.LocalDateTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.novaix.govconnect_server.dao.PasswordResetTokenDao;
import com.novaix.govconnect_server.dao.UsersDao;
import com.novaix.govconnect_server.exception.custom.InvalidInputException;
import com.novaix.govconnect_server.exception.custom.InvalidOtpException;
import com.novaix.govconnect_server.exception.custom.OtpExpiredException;
import com.novaix.govconnect_server.repository.PasswordResetTokenRepository;
import com.novaix.govconnect_server.repository.UserRepository;
import com.novaix.govconnect_server.request.ForgotPasswordRequest;
import com.novaix.govconnect_server.request.ResetPasswordRequest;
import com.novaix.govconnect_server.response.ForgotPasswordResponse;
import com.novaix.govconnect_server.response.ResetPasswordResponse;
import com.novaix.govconnect_server.service.email.EmailService;

@ExtendWith(MockitoExtension.class)
class PasswordResetServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private PasswordResetTokenRepository passwordResetTokenRepository;

    @Mock
    private EmailService emailService;

    @Mock
    private BCryptPasswordEncoder passwordEncoder;

    @InjectMocks
    private PasswordResetService passwordResetService;

    private UsersDao testUser;
    private ForgotPasswordRequest forgotPasswordRequest;
    private ResetPasswordRequest resetPasswordRequest;

    @BeforeEach
    void setUp() {
        testUser = new UsersDao();
        testUser.setId(1L);
        testUser.setEmail("test@example.com");
        testUser.setPassword("oldPassword");

        forgotPasswordRequest = new ForgotPasswordRequest();
        forgotPasswordRequest.setEmail("test@example.com");

        resetPasswordRequest = new ResetPasswordRequest();
        resetPasswordRequest.setEmail("test@example.com");
        resetPasswordRequest.setOtp("123456");
        resetPasswordRequest.setNewPassword("NewPassword123!");
    }

    @Test
    void forgotPassword_ValidEmail_ShouldSendOtpSuccessfully() {
        // Given
        when(userRepository.findByEmail("test@example.com")).thenReturn(testUser);
        when(passwordResetTokenRepository.save(any(PasswordResetTokenDao.class)))
                .thenReturn(new PasswordResetTokenDao());
        doNothing().when(emailService).sendOtpEmail(anyString(), anyString(), any(LocalDateTime.class));

        // When
        ForgotPasswordResponse response = passwordResetService.forgotPassword(forgotPasswordRequest);

        // Then
        assertNotNull(response);
        assertEquals("OTP sent successfully to your email address", response.getMessage());
        assertEquals("test@example.com", response.getEmail());
        assertNotNull(response.getExpiryTime());

        verify(userRepository).findByEmail("test@example.com");
        verify(passwordResetTokenRepository).markAllTokensAsUsedByUser(testUser);
        verify(passwordResetTokenRepository).save(any(PasswordResetTokenDao.class));
        verify(emailService).sendOtpEmail(eq("test@example.com"), anyString(), any(LocalDateTime.class));
    }

    @Test
    void forgotPassword_InvalidEmail_ShouldThrowException() {
        // Given
        when(userRepository.findByEmail("invalid@example.com")).thenReturn(null);
        forgotPasswordRequest.setEmail("invalid@example.com");

        // When & Then
        InvalidInputException exception = assertThrows(InvalidInputException.class,
                () -> passwordResetService.forgotPassword(forgotPasswordRequest));

        assertEquals("No account found with email: invalid@example.com", exception.getMessage());
        verify(userRepository).findByEmail("invalid@example.com");
        verifyNoInteractions(passwordResetTokenRepository, emailService);
    }

    @Test
    void resetPassword_ValidOtp_ShouldResetPasswordSuccessfully() {
        // Given
        PasswordResetTokenDao validToken = PasswordResetTokenDao.builder()
                .id("token-id")
                .otp("123456")
                .expiryDate(LocalDateTime.now().plusMinutes(5))
                .used(false)
                .user(testUser)
                .build();

        when(userRepository.findByEmail("test@example.com")).thenReturn(testUser);
        when(passwordResetTokenRepository.findByUserAndOtpAndUsedFalse(testUser, "123456"))
                .thenReturn(Optional.of(validToken));
        when(passwordEncoder.encode("NewPassword123!")).thenReturn("encodedPassword");
        when(userRepository.save(testUser)).thenReturn(testUser);
        when(passwordResetTokenRepository.save(validToken)).thenReturn(validToken);

        // When
        ResetPasswordResponse response = passwordResetService.resetPassword(resetPasswordRequest);

        // Then
        assertNotNull(response);
        assertEquals("Password reset successfully", response.getMessage());
        assertEquals("test@example.com", response.getEmail());

        verify(userRepository).findByEmail("test@example.com");
        verify(passwordResetTokenRepository).findByUserAndOtpAndUsedFalse(testUser, "123456");
        verify(passwordEncoder).encode("NewPassword123!");
        verify(userRepository).save(testUser);
        verify(passwordResetTokenRepository).save(validToken);

        assertTrue(validToken.isUsed());
        assertEquals("encodedPassword", testUser.getPassword());
    }

    @Test
    void resetPassword_InvalidOtp_ShouldThrowException() {
        // Given
        when(userRepository.findByEmail("test@example.com")).thenReturn(testUser);
        when(passwordResetTokenRepository.findByUserAndOtpAndUsedFalse(testUser, "123456"))
                .thenReturn(Optional.empty());

        // When & Then
        InvalidOtpException exception = assertThrows(InvalidOtpException.class,
                () -> passwordResetService.resetPassword(resetPasswordRequest));

        assertEquals("Invalid OTP provided", exception.getMessage());
        verify(userRepository).findByEmail("test@example.com");
        verify(passwordResetTokenRepository).findByUserAndOtpAndUsedFalse(testUser, "123456");
        verifyNoInteractions(passwordEncoder);
        verify(userRepository, never()).save(any());
    }

    @Test
    void resetPassword_ExpiredOtp_ShouldThrowException() {
        // Given
        PasswordResetTokenDao expiredToken = PasswordResetTokenDao.builder()
                .id("token-id")
                .otp("123456")
                .expiryDate(LocalDateTime.now().minusMinutes(10)) // Expired
                .used(false)
                .user(testUser)
                .build();

        when(userRepository.findByEmail("test@example.com")).thenReturn(testUser);
        when(passwordResetTokenRepository.findByUserAndOtpAndUsedFalse(testUser, "123456"))
                .thenReturn(Optional.of(expiredToken));

        // When & Then
        OtpExpiredException exception = assertThrows(OtpExpiredException.class,
                () -> passwordResetService.resetPassword(resetPasswordRequest));

        assertEquals("OTP has expired. Please request a new one", exception.getMessage());
        verify(userRepository).findByEmail("test@example.com");
        verify(passwordResetTokenRepository).findByUserAndOtpAndUsedFalse(testUser, "123456");
        verifyNoInteractions(passwordEncoder);
        verify(userRepository, never()).save(any());
    }
}
