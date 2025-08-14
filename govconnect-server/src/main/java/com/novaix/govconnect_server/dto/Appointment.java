package com.novaix.govconnect_server.dto;

import com.novaix.govconnect_server.enums.AppointmentStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.LocalTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Appointment {
    private Long id;
    private LocalDateTime AppointmentDate;
    private LocalTime startTime;
    private LocalTime endTime;
    private AppointmentStatus status;
    private Boolean isUrgent;
    private String urgencyReason;
}
