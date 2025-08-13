package com.novaix.govconnect_server.service.auth.impl;

import com.novaix.govconnect_server.dao.UsersDao;
import com.novaix.govconnect_server.dto.UserPrinciple;
import com.novaix.govconnect_server.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UsersDao usersDao = userRepository.findByEmail(username);

        if(usersDao == null){
            log.error("User not found with username: {}", username);
            throw new UsernameNotFoundException(username+" not found!");
        }
        return new UserPrinciple(usersDao);
    }
}
