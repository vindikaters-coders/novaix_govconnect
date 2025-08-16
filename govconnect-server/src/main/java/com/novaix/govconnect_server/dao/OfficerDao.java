package com.novaix.govconnect_server.dao;

import com.novaix.govconnect_server.common.BaseAuditingEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "officers")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class OfficerDao extends BaseAuditingEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;
    
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private UsersDao user;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id", nullable = false)
    private DepartmentDao department;
    
    @Column(nullable = false)
    private String position;
    
    @Column(nullable = false)
    private String employeeId;
    
    @Column(nullable = false)
    private boolean active = true;
    
    @Column
    private String specialization;
}
