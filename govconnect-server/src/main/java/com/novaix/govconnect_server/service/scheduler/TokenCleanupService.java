package com.novaix.govconnect_server.service.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.novaix.govconnect_server.service.password.PasswordResetService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TokenCleanupService {

    private final PasswordResetService passwordResetService;

    // Run every hour
    @Scheduled(fixedRate = 3600000)
    public void cleanupExpiredTokens() {
        try {
            passwordResetService.cleanupExpiredTokens();
            log.info("Expired password reset tokens cleaned up successfully");
        } catch (Exception e) {
            log.error("Failed to cleanup expired tokens", e);
        }
    }
}
