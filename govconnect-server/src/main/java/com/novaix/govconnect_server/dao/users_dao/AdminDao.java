package com.novaix.govconnect_server.dao.users_dao;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "user_admin")
@DiscriminatorValue("ADMIN")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class AdminDao extends UsersDao{
    private String postalCode;
}
