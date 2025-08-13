package com.novaix.govconnect_server.service.auth.impl;

import com.novaix.govconnect_server.dao.UsersDao;
import com.novaix.govconnect_server.dto.Users;
import com.novaix.govconnect_server.exeption.custom.InternalServerErrorException;
import com.novaix.govconnect_server.exeption.custom.InvalidInputException;
import com.novaix.govconnect_server.exeption.custom.UnauthorizedException;
import com.novaix.govconnect_server.repository.UserRepository;
import com.novaix.govconnect_server.request.UserLoginRequest;
import com.novaix.govconnect_server.response.AuthResponse;
import com.novaix.govconnect_server.service.auth.AuthService;
import com.novaix.govconnect_server.validator.UserValidator;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.beans.BeansException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final JwtService jwtService;
    private final UserRepository userRepository;
    private final AuthenticationManager authManager;
    private final ModelMapper mapper;
    private final BCryptPasswordEncoder encoder;

    @Override
    public AuthResponse verify(UserLoginRequest request) {
        try {
            if (!UserValidator.isValidateEmail(request.getEmail())) {
                throw new InvalidInputException("Invalid email");
            }

            Authentication authentication = authManager
                    .authenticate(
                            new UsernamePasswordAuthenticationToken(
                                    request.getEmail(),
                                    request.getPassword()
                            )
                    );

            if (authentication.isAuthenticated()){
                String token = jwtService.generateToken(authentication);
                UsersDao usersDao = userRepository.findByEmail(request.getEmail());
                if (usersDao == null) {
                    throw new UnauthorizedException("User not found");
                }
                return new AuthResponse(token, mapper.map(usersDao, Users.class));
            }
            throw new UnauthorizedException("Invalid access");
        } catch (AuthenticationException e) {
            log.error("UserAuthenticationServiceImpl Section 1: {}", e.getMessage());
            throw new UnauthorizedException(e.getMessage());
        } catch (NullPointerException | IndexOutOfBoundsException | BeansException e) {
            log.error("UserAuthenticationServiceImpl Section 2: {}", e.getMessage());
            throw new InternalServerErrorException(e.getMessage());
        } catch (RuntimeException e) {
            log.error("RuntimeException in UserAuthenticationServiceImpl: {}", e.getMessage());
            throw new InternalServerErrorException(e.getMessage());
        }
    }
}
