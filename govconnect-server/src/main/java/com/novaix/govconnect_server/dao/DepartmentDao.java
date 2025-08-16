package com.novaix.govconnect_server.dao;

import com.novaix.govconnect_server.common.Address;
import com.novaix.govconnect_server.common.BaseAuditingEntity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.NaturalId;

@Entity
@Table(name = "departments")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class DepartmentDao extends BaseAuditingEntity {
    
    @Id
    @Column(name = "department_id")
    private String departmentId;

    @Column(nullable = false, unique = true)
    private String name;

    @Embedded
    private Address address;

    @Column(name = "contact_email")
    private String contactEmail;

    @Column(name = "contact_phone")
    private String contactPhone;
}
