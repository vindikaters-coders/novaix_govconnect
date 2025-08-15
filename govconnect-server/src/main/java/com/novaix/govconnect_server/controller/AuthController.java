package com.novaix.govconnect_server.controller;

import com.novaix.govconnect_server.dto.users_dto.Admin;
import com.novaix.govconnect_server.dto.users_dto.Client;
import com.novaix.govconnect_server.dto.users_dto.Users;
import com.novaix.govconnect_server.request.AdminRegistrationRequest;
import com.novaix.govconnect_server.request.ClientRegistrationRequest;
import com.novaix.govconnect_server.request.UserLoginRequest;
import com.novaix.govconnect_server.request.UserRegistrationRequest;
import com.novaix.govconnect_server.response.ApiResponse;
import com.novaix.govconnect_server.response.AuthResponse;
import com.novaix.govconnect_server.service.auth.impl.AuthServiceImpl;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

import static com.novaix.govconnect_server.validator.UserValidator.USER_VALIDATION_FAILED_ERROR;

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
    public ResponseEntity<ApiResponse> registerUser(@Valid @RequestBody ClientRegistrationRequest request, BindingResult bindingResult){
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = new HashMap<>();
            for (FieldError error : bindingResult.getFieldErrors()) {
                errors.put(error.getField(), error.getDefaultMessage());
            }
            return ResponseEntity.badRequest().body(new ApiResponse(USER_VALIDATION_FAILED_ERROR, errors));
        }
        Client user=authService.registerUser(request);
        return ResponseEntity.status(201).body(new ApiResponse("User registered successfully!!", user));
    }

    @PreAuthorize("hasRole('ROLE_SUPERADMIN')")
    @PostMapping("/register/admin")
    public ResponseEntity<ApiResponse> registerAdmin(@Valid @RequestBody AdminRegistrationRequest request, BindingResult bindingResult){
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = new HashMap<>();
            for (FieldError error : bindingResult.getFieldErrors()) {
                errors.put(error.getField(), error.getDefaultMessage());
            }
            return ResponseEntity.badRequest().body(new ApiResponse(USER_VALIDATION_FAILED_ERROR, errors));
        }
        Admin user=authService.registerAdmin(request);
        return ResponseEntity.status(201).body(new ApiResponse("Admin user registered successfully!!", user));
    }
}
