package com.novaix.govconnect_server.service.common.impl;

import com.novaix.govconnect_server.enums.Role;
import com.novaix.govconnect_server.service.common.EmailService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender javaMailSender;
    private final TemplateEngine templateEngine;

    @Override
    public void sendEmail(String to, String subject, String templateName, Map<String, Object> templateVariables) throws MessagingException {
        Context context =  new Context();
        context.setVariables(templateVariables);

        String htmlContent = templateEngine.process(templateName,context);

        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setFrom("vinuthsriarampth@gmail.com");
        helper.setTo(to);
        helper.setSubject(subject);
        helper.setText(htmlContent, true);

        try{
            javaMailSender.send(message);
        }catch (MailException ex){
            log.error("Failed to send email",ex);
        }

    }

    @Override
    public void SendRegistrationSuccessEmail(String email, String name, Role role) {
        try{

            Map<String, Object> templateVariables = new HashMap<>();
            templateVariables.put("name",name);
            templateVariables.put("role", role);

            sendEmail(email,"Welcome To GovConnect","registration-success",templateVariables);
        }catch (MessagingException ex){
            log.error("Error sending registration success email to {}: {}", email, ex.getMessage());
            throw new RuntimeException("Failed to send registration success email", ex);
        }
    }
}
