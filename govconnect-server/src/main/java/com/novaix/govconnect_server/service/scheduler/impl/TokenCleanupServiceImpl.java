package com.novaix.govconnect_server.service.scheduler.impl;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.novaix.govconnect_server.service.password.PasswordResetService;
import com.novaix.govconnect_server.service.scheduler.TokenCleanupService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class TokenCleanupServiceImpl implements TokenCleanupService {

    private final PasswordResetService passwordResetService;

    @Override
    @Scheduled(fixedRate = 3600000)
    public void performScheduledTokenCleanup() {
        log.info("Starting scheduled cleanup of expired password reset tokens");
        try {
            passwordResetService.cleanupExpiredTokens();
            log.info("Scheduled cleanup of expired password reset tokens completed successfully");
        } catch (Exception e) {
            log.error("Failed to cleanup expired tokens during scheduled execution", e);
        }
    }
}
