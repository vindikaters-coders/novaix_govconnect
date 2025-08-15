package com.novaix.govconnect_server.dao.users_dao;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "user_superadmin")
@DiscriminatorValue("SUPERADMIN")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SuperAdminDao extends UsersDao{
    private String postalCode;
}
