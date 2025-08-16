package com.novaix.govconnect_server.service.password.impl;

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
import com.novaix.govconnect_server.service.common.EmailService;
import com.novaix.govconnect_server.service.password.PasswordResetService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class PasswordResetServiceImpl implements PasswordResetService {

    private final UserRepository userRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final EmailService emailService;
    private final BCryptPasswordEncoder passwordEncoder;
    private final SecureRandom secureRandom = new SecureRandom();

    @Override
    public ForgotPasswordResponse forgotPassword(ForgotPasswordRequest request) {
        log.info("Processing forgot password request for email: {}", request.getEmail());
        
        String email = request.getEmail().toLowerCase().trim();
        
        UsersDao user = userRepository.findByEmail(email);
        if (user == null) {
            log.error("No account found with email: {}", email);
            throw new InvalidInputException("No account found with email: " + email);
        }

        // Mark all existing tokens as used
        passwordResetTokenRepository.markAllTokensAsUsedByUser(user);

        String otp = generateOtp();
        LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(5);

        PasswordResetTokenDao resetToken = PasswordResetTokenDao.builder()
                .otp(otp)
                .expiryDate(expiryTime)
                .used(false)
                .user(user)
                .build();

        passwordResetTokenRepository.save(resetToken);
        log.info("Password reset token generated for user: {}", email);

        emailService.sendOtpEmail(email, otp, expiryTime);

        return new ForgotPasswordResponse(
                "OTP sent successfully to your email address",
                email,
                expiryTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
        );
    }

    @Override
    public ResetPasswordResponse resetPassword(ResetPasswordRequest request) {
        log.info("Processing password reset request for email: {}", request.getEmail());
        
        String email = request.getEmail().toLowerCase().trim();
        String otp = request.getOtp();
        String newPassword = request.getNewPassword();

        UsersDao user = userRepository.findByEmail(email);
        if (user == null) {
            log.error("No account found with email: {}", email);
            throw new InvalidInputException("No account found with email: " + email);
        }

        Optional<PasswordResetTokenDao> tokenOpt = passwordResetTokenRepository
                .findByUserAndOtpAndUsedFalse(user, otp);

        if (tokenOpt.isEmpty()) {
            log.error("Invalid OTP provided for email: {}", email);
            throw new InvalidOtpException("Invalid OTP provided");
        }

        PasswordResetTokenDao token = tokenOpt.get();

        if (token.isExpired()) {
            log.error("Expired OTP used for email: {}", email);
            throw new OtpExpiredException("OTP has expired. Please request a new one");
        }

        String encodedPassword = passwordEncoder.encode(newPassword);
        user.setPassword(encodedPassword);
        userRepository.save(user);

        token.setUsed(true);
        passwordResetTokenRepository.save(token);

        log.info("Password reset successfully for user: {}", email);
        return new ResetPasswordResponse(
                "Password reset successfully",
                email
        );
    }

    @Override
    @Transactional
    public void cleanupExpiredTokens() {
        log.info("Starting cleanup of expired password reset tokens");
        try {
            passwordResetTokenRepository.deleteExpiredTokens(LocalDateTime.now());
            log.info("Expired password reset tokens cleaned up successfully");
        } catch (Exception e) {
            log.error("Failed to cleanup expired tokens", e);
            throw e;
        }
    }

    private String generateOtp() {
        return String.format("%06d", secureRandom.nextInt(1000000));
    }
}
