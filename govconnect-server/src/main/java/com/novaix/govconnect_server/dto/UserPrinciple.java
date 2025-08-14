package com.novaix.govconnect_server.dto;

import com.novaix.govconnect_server.dao.UsersDao;
import lombok.AllArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

@AllArgsConstructor
public class UserPrinciple implements UserDetails {

    private transient UsersDao usersDao;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singleton(new SimpleGrantedAuthority(usersDao.getRole().name()));
    }

    @Override
    public String getPassword() {
        return usersDao.getPassword();
    }

    @Override
    public String getUsername() {
        return usersDao.getEmail();
    }
}
