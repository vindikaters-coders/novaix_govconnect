package com.novaix.govconnect_server.repository;

import com.novaix.govconnect_server.dao.DepartmentDao;
import com.novaix.govconnect_server.dao.OfficerDao;
import com.novaix.govconnect_server.dao.UsersDao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OfficerRepository extends JpaRepository<OfficerDao, String> {
    
    Optional<OfficerDao> findByUser(UsersDao user);
    
    List<OfficerDao> findByDepartmentAndActiveTrue(DepartmentDao department);
    
    List<OfficerDao> findByActiveTrue();
    
    boolean existsByEmployeeId(String employeeId);
}
