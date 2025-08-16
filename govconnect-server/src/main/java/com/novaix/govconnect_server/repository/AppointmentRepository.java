package com.novaix.govconnect_server.repository;

import com.novaix.govconnect_server.dao.AppointmentDao;
import com.novaix.govconnect_server.dao.OfficerDao;
import com.novaix.govconnect_server.dao.UsersDao;
import com.novaix.govconnect_server.enums.AppointmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface AppointmentRepository extends JpaRepository<AppointmentDao, String> {
    
    List<AppointmentDao> findByUserOrderByAppointmentDateDesc(UsersDao user);
    
    List<AppointmentDao> findByOfficerOrderByAppointmentDateDesc(OfficerDao officer);
    
    List<AppointmentDao> findByUserAndStatus(UsersDao user, AppointmentStatus status);
    
    List<AppointmentDao> findByOfficerAndStatus(OfficerDao officer, AppointmentStatus status);
    
    @Query("SELECT a FROM AppointmentDao a WHERE a.appointmentDate = :date AND a.officer = :officer " +
           "AND a.status NOT IN ('CANCELLED', 'REJECTED')")
    List<AppointmentDao> findByDateAndOfficerAndNotCancelledOrRejected(
        @Param("date") LocalDate date, 
        @Param("officer") OfficerDao officer
    );
    
    @Query("SELECT a FROM AppointmentDao a WHERE a.appointmentDate BETWEEN :startDate AND :endDate " +
           "AND a.officer = :officer AND a.status NOT IN ('CANCELLED', 'REJECTED')")
    List<AppointmentDao> findByDateRangeAndOfficerAndNotCancelledOrRejected(
        @Param("startDate") LocalDate startDate,
        @Param("endDate") LocalDate endDate,
        @Param("officer") OfficerDao officer
    );
}
