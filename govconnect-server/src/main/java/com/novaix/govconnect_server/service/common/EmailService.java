package com.novaix.govconnect_server.service.common;

import com.novaix.govconnect_server.enums.Role;
import jakarta.mail.MessagingException;

import java.time.LocalDateTime;
import java.util.Map;

public interface EmailService {
    void sendEmail(String to, String subject, String templateName, Map<String, Object> templateVariables) throws MessagingException;

    void SendRegistrationSuccessEmail(String email, String name, Role role);
    
    void sendOtpEmail(String toEmail, String otp, LocalDateTime expiryTime);
}
