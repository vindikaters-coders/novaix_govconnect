package com.novaix.govconnect_server.controller;

import com.novaix.govconnect_server.request.UserLoginRequest;
import com.novaix.govconnect_server.response.AuthResponse;
import com.novaix.govconnect_server.service.auth.impl.AuthServiceImpl;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthServiceImpl authService;

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody UserLoginRequest userLoginRequest){
        AuthResponse authResponse = authService.verify(userLoginRequest);
        return ResponseEntity.ok(authResponse);
    }
}
