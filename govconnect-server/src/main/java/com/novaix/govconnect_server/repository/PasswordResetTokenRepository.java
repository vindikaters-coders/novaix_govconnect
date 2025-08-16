package com.novaix.govconnect_server.repository;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.novaix.govconnect_server.dao.PasswordResetTokenDao;
import com.novaix.govconnect_server.dao.UsersDao;

@Repository
public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetTokenDao, String> {
    
    Optional<PasswordResetTokenDao> findByUserAndOtpAndUsedFalse(UsersDao user, String otp);
    
    Optional<PasswordResetTokenDao> findByUserAndUsedFalse(UsersDao user);
    
    @Modifying
    @Query("UPDATE PasswordResetTokenDao p SET p.used = true WHERE p.user = :user AND p.used = false")
    void markAllTokensAsUsedByUser(@Param("user") UsersDao user);
    
    @Modifying
    @Query("DELETE FROM PasswordResetTokenDao p WHERE p.expiryDate < :currentTime")
    void deleteExpiredTokens(@Param("currentTime") LocalDateTime currentTime);
}
