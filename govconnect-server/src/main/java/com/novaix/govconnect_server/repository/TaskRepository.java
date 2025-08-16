package com.novaix.govconnect_server.repository;

import com.novaix.govconnect_server.dao.DepartmentDao;
import com.novaix.govconnect_server.dao.OfficerDao;
import com.novaix.govconnect_server.dao.TaskDao;
import com.novaix.govconnect_server.dao.UsersDao;
import com.novaix.govconnect_server.enums.AppointmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<TaskDao, String> {
    
    List<TaskDao> findByUserOrderByCreatedDateDesc(UsersDao user);
    
    List<TaskDao> findByAssignedOfficerOrderByCreatedDateDesc(OfficerDao officer);
    
    List<TaskDao> findByDepartmentOrderByCreatedDateDesc(DepartmentDao department);
    
    List<TaskDao> findByStatus(AppointmentStatus status);
    
    List<TaskDao> findByUserAndStatus(UsersDao user, AppointmentStatus status);
}
