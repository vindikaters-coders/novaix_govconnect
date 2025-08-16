package com.novaix.govconnect_server.service.user;

import com.novaix.govconnect_server.request.UserUpdateRequest;
import com.novaix.govconnect_server.response.UserUpdateResponse;

public interface UserService {
    UserUpdateResponse updateUser(Long userId, UserUpdateRequest request, String authenticatedUserEmail);
}
