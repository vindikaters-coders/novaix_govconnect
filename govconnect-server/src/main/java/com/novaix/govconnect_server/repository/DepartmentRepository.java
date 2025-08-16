package com.novaix.govconnect_server.repository;

import com.novaix.govconnect_server.dao.DepartmentDao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DepartmentRepository extends JpaRepository<DepartmentDao, String> {
    
    Optional<DepartmentDao> findByName(String name);
    
    List<DepartmentDao> findByActiveTrue();
    
    boolean existsByName(String name);
}
