package com.novaix.govconnect_server.controller;

import com.novaix.govconnect_server.request.UserUpdateRequest;
import com.novaix.govconnect_server.response.UserUpdateResponse;
import com.novaix.govconnect_server.service.user.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final UserService userService;

    @PutMapping("/{id}")
    public ResponseEntity<UserUpdateResponse> updateUser(
            @PathVariable Long id,
            @Valid @RequestBody UserUpdateRequest request,
            @AuthenticationPrincipal UserDetails userDetails) {
        
        log.info("Update request received for user ID: {} by authenticated user: {}", id, userDetails.getUsername());
        
        UserUpdateResponse response = userService.updateUser(id, request, userDetails.getUsername());
        return ResponseEntity.ok(response);
    }
}
