package com.novaix.govconnect_server.dao;

import com.novaix.govconnect_server.common.Address;
import com.novaix.govconnect_server.common.BaseAuditingEntity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.NaturalId;


@Entity
@Table(name = "Department")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class DepartmentDao extends BaseAuditingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Embedded
    private Address address;

    @Column(nullable = false,unique = true)
    private String contact;

    @NaturalId
    @Column(nullable = false,unique = true)
    private String email;
}
