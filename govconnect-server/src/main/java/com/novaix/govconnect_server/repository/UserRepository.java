package com.novaix.govconnect_server.repository;

import com.novaix.govconnect_server.dao.UsersDao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UsersDao, Long> {
    UsersDao findByEmail(String email);

    boolean existsByEmail(String email);

    boolean existsByNic(String nic);
}
