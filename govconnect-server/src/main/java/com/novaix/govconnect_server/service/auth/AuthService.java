package com.novaix.govconnect_server.service.auth;

import com.novaix.govconnect_server.dto.users_dto.Admin;
import com.novaix.govconnect_server.dto.users_dto.Client;
import com.novaix.govconnect_server.dto.users_dto.Users;
import com.novaix.govconnect_server.request.AdminRegistrationRequest;
import com.novaix.govconnect_server.request.ClientRegistrationRequest;
import com.novaix.govconnect_server.request.UserLoginRequest;
import com.novaix.govconnect_server.request.UserRegistrationRequest;
import com.novaix.govconnect_server.response.AuthResponse;
import jakarta.validation.Valid;

public interface AuthService {
    AuthResponse verify(UserLoginRequest request);

    Client registerUser(@Valid ClientRegistrationRequest request);

    Admin registerAdmin(@Valid AdminRegistrationRequest request);
}
