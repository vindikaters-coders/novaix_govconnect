package com.novaix.govconnect_server.controller;

import com.novaix.govconnect_server.dto.Users;
import com.novaix.govconnect_server.request.UserLoginRequest;
import com.novaix.govconnect_server.request.UserRegistrationRequest;
import com.novaix.govconnect_server.response.ApiResponse;
import com.novaix.govconnect_server.response.AuthResponse;
import com.novaix.govconnect_server.service.auth.impl.AuthServiceImpl;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@SuppressWarnings("unused")
@RequestMapping("api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthServiceImpl authService;

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody UserLoginRequest userLoginRequest){
        AuthResponse authResponse = authService.verify(userLoginRequest);
        return ResponseEntity.ok(authResponse);
    }

    @PostMapping("/register/user")
    public ResponseEntity<ApiResponse> registerUser(@Valid @RequestBody UserRegistrationRequest request){
        Users user=authService.registerUser(request, "user");
        return ResponseEntity.status(201).body(new ApiResponse("User registered successfully!!", user));
    }

    @PreAuthorize("hasRole('ROLE_SUPERADMIN')")
    @PostMapping("/register/admin")
    public ResponseEntity<ApiResponse> registerAdmin(@Valid @RequestBody UserRegistrationRequest request){
        System.out.println("Registering admin user: " + request.getEmail());
        Users user=authService.registerUser(request, "admin");
        return ResponseEntity.status(201).body(new ApiResponse("Admin user registered successfully!!", user));
    }
}
