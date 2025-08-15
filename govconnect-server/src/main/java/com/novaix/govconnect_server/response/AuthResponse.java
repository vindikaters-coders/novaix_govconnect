package com.novaix.govconnect_server.response;

import com.novaix.govconnect_server.dto.users_dto.Users;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AuthResponse {
    private String token;
    private Users user;
}
