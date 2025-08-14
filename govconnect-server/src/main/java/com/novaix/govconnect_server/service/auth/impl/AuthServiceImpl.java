package com.novaix.govconnect_server.service.auth.impl;

import com.novaix.govconnect_server.dao.UsersDao;
import com.novaix.govconnect_server.dto.Users;
import com.novaix.govconnect_server.enums.Role;
import com.novaix.govconnect_server.exeption.custom.AlreadyExistsException;
import com.novaix.govconnect_server.exeption.custom.InternalServerErrorException;
import com.novaix.govconnect_server.exeption.custom.InvalidInputException;
import com.novaix.govconnect_server.exeption.custom.UnauthorizedException;
import com.novaix.govconnect_server.repository.UserRepository;
import com.novaix.govconnect_server.request.UserLoginRequest;
import com.novaix.govconnect_server.request.UserRegistrationRequest;
import com.novaix.govconnect_server.response.AuthResponse;
import com.novaix.govconnect_server.service.auth.AuthService;
import com.novaix.govconnect_server.service.common.EmailService;
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
    private final EmailService emailService;

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

            if (authentication.isAuthenticated()) {
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

    @Override
    public Users registerUser(UserRegistrationRequest request, String role) {

        try {
            if (!UserValidator.isValidateEmail(request.getEmail())) {
                throw new InvalidInputException("Invalid email format.");
            }
            if (!UserValidator.isValidatePassword(request.getPassword())) {
                throw new InvalidInputException("Password does not meet security requirements.");
            }
            if (userRepository.existsByEmail(request.getEmail())) {
                throw new AlreadyExistsException("User with this email already exists.");
            }
            if (userRepository.existsByNic(request.getNic())){
                throw new AlreadyExistsException("User with this NIC already exists.");
            }
            if (!UserValidator.isValidDob(request.getDob())) {
                throw new InvalidInputException("You must be at least 18 years old.");
            }


            UsersDao usersDao = mapper.map(request, UsersDao.class);

            switch (role) {
                case "user":
                    usersDao.setRole(Role.ROLE_USER);
                    break;
                case "admin":
                    usersDao.setRole(Role.ROLE_ADMIN);
                    break;
                default:
                    throw new InvalidInputException("Invalid role specified.");
            }

            usersDao.setPassword(encoder.encode(request.getPassword()));
            UsersDao savedUser = userRepository.save(usersDao);
            emailService.SendRegistrationSuccessEmail(savedUser.getEmail(), savedUser.getFirstname()+" "+savedUser.getLastname(),savedUser.getRole());

            return mapper.map(savedUser, Users.class);
        } catch (BeansException e) {
            log.error("Error in AuthServiceImpl: {}", e.getMessage());
            throw new InternalServerErrorException(e.getMessage());
        }
    }
}
