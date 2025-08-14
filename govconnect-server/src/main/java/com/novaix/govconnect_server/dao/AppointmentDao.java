package com.novaix.govconnect_server.dao;

import com.novaix.govconnect_server.common.BaseAuditingEntity;
import com.novaix.govconnect_server.enums.AppointmentStatus;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class AppointmentDao extends BaseAuditingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private LocalDateTime AppointmentDate;

    @Column(nullable = false)
    private LocalTime startTime;

    @Column(nullable = false)
    private LocalTime endTime;

    @Column(nullable = false)
    private AppointmentStatus status;

    @Column(nullable = false)
    private Boolean isUrgent;

    @Column(nullable = true)
    private String urgencyReason;
}
