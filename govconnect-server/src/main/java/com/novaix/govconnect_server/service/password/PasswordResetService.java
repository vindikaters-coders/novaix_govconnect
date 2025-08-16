package com.novaix.govconnect_server.service.password;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class PasswordResetService {

    private final UserRepository userRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final EmailService emailService;
    private final BCryptPasswordEncoder passwordEncoder;
    private final SecureRandom secureRandom = new SecureRandom();

    public ForgotPasswordResponse forgotPassword(ForgotPasswordRequest request) {
        String email = request.getEmail().toLowerCase().trim();
        
        // Check if user exists
        UsersDao user = userRepository.findByEmail(email);
        if (user == null) {
            throw new InvalidInputException("No account found with email: " + email);
        }

        // Mark any existing tokens as used
        passwordResetTokenRepository.markAllTokensAsUsedByUser(user);

        // Generate OTP
        String otp = generateOtp();
        LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(5);

        // Create and save password reset token
        PasswordResetTokenDao resetToken = PasswordResetTokenDao.builder()
                .otp(otp)
                .expiryDate(expiryTime)
                .used(false)
                .user(user)
                .build();

        passwordResetTokenRepository.save(resetToken);

        // Send email
        emailService.sendOtpEmail(email, otp, expiryTime);

        return new ForgotPasswordResponse(
                "OTP sent successfully to your email address",
                email,
                expiryTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
        );
    }

    public ResetPasswordResponse resetPassword(ResetPasswordRequest request) {
        String email = request.getEmail().toLowerCase().trim();
        String otp = request.getOtp();
        String newPassword = request.getNewPassword();

        // Find user
        UsersDao user = userRepository.findByEmail(email);
        if (user == null) {
            throw new InvalidInputException("No account found with email: " + email);
        }

        // Find valid token
        Optional<PasswordResetTokenDao> tokenOpt = passwordResetTokenRepository
                .findByUserAndOtpAndUsedFalse(user, otp);

        if (tokenOpt.isEmpty()) {
            throw new InvalidOtpException("Invalid OTP provided");
        }

        PasswordResetTokenDao token = tokenOpt.get();

        // Check if token is expired
        if (token.isExpired()) {
            throw new OtpExpiredException("OTP has expired. Please request a new one");
        }

        // Update password
        String encodedPassword = passwordEncoder.encode(newPassword);
        user.setPassword(encodedPassword);
        userRepository.save(user);

        // Mark token as used
        token.setUsed(true);
        passwordResetTokenRepository.save(token);

        return new ResetPasswordResponse(
                "Password reset successfully",
                email
        );
    }

    private String generateOtp() {
        return String.format("%06d", secureRandom.nextInt(1000000));
    }

    // Cleanup method to remove expired tokens (can be called by a scheduled job)
    @Transactional
    public void cleanupExpiredTokens() {
        passwordResetTokenRepository.deleteExpiredTokens(LocalDateTime.now());
    }
}
