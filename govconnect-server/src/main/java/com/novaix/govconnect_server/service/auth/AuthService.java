package com.novaix.govconnect_server.service.auth;

import com.novaix.govconnect_server.request.UserLoginRequest;
import com.novaix.govconnect_server.response.AuthResponse;

public interface AuthService {
    AuthResponse verify(UserLoginRequest request);
}
