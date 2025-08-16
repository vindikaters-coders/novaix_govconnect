package com.novaix.govconnect_server.dao;

import com.novaix.govconnect_server.common.BaseAuditingEntity;
import com.novaix.govconnect_server.enums.AppointmentStatus;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Entity
@Table(name = "appointments")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class AppointmentDao extends BaseAuditingEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UsersDao user;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "officer_id", nullable = false)
    private OfficerDao officer;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id", nullable = false)
    private DepartmentDao department;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "task_id", nullable = false)
    private TaskDao task;
    
    @Column(nullable = false)
    private LocalDate appointmentDate;
    
    @Column(nullable = false)
    private LocalTime startTime;
    
    @Column(nullable = false)
    private LocalTime endTime;
    
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private AppointmentStatus status;
    
    @Column(nullable = false)
    private boolean urgencyFlag = false;
    
    @Column
    private String urgencyReason;
    
    @Column
    private String rejectionReason;
    
    @Column
    private String notes;
    
    @ElementCollection
    @CollectionTable(name = "appointment_transfer_history", 
                    joinColumns = @JoinColumn(name = "appointment_id"))
    @Column(name = "transfer_note")
    private List<String> transferHistory;
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "appointment_additional_officers",
        joinColumns = @JoinColumn(name = "appointment_id"),
        inverseJoinColumns = @JoinColumn(name = "officer_id")
    )
    private List<OfficerDao> additionalOfficers;
}
