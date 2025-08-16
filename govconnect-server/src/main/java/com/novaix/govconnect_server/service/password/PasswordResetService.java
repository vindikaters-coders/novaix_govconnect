package com.novaix.govconnect_server.service.password;

import com.novaix.govconnect_server.request.ForgotPasswordRequest;
import com.novaix.govconnect_server.request.ResetPasswordRequest;
import com.novaix.govconnect_server.response.ForgotPasswordResponse;
import com.novaix.govconnect_server.response.ResetPasswordResponse;

public interface PasswordResetService {
    
    ForgotPasswordResponse forgotPassword(ForgotPasswordRequest request);
    
    ResetPasswordResponse resetPassword(ResetPasswordRequest request);
    
    void cleanupExpiredTokens();
}
