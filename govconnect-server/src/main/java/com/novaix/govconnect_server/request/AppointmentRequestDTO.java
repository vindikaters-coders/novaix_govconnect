package com.novaix.govconnect_server.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AppointmentRequestDTO {
    
    @NotBlank(message = "Task ID is required")
    private String taskId;
    
    @NotBlank(message = "Officer ID is required")
    private String officerId;
    
    @NotBlank(message = "Department ID is required")
    private String departmentId;
    
    @NotNull(message = "Appointment date is required")
    @Future(message = "Appointment date must be in the future")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate appointmentDate;
    
    @NotNull(message = "Start time is required")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm")
    private LocalTime startTime;
    
    @NotNull(message = "End time is required")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm")
    private LocalTime endTime;
    
    private boolean urgencyFlag = false;
    
    @Size(max = 500, message = "Urgency reason cannot exceed 500 characters")
    private String urgencyReason;
    
    @Size(max = 1000, message = "Notes cannot exceed 1000 characters")
    private String notes;
}
