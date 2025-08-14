package com.novaix.govconnect_server.service.auth;

import com.novaix.govconnect_server.dto.Users;
import com.novaix.govconnect_server.request.UserLoginRequest;
import com.novaix.govconnect_server.request.UserRegistrationRequest;
import com.novaix.govconnect_server.response.AuthResponse;
import jakarta.validation.Valid;

public interface AuthService {
    AuthResponse verify(UserLoginRequest request);

    Users registerUser(@Valid UserRegistrationRequest request, String role);
}
