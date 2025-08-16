package com.novaix.govconnect_server.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.novaix.govconnect_server.enums.AppointmentStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AppointmentResponseDTO {
    
    @JsonProperty(index = 1)
    private String id;
    
    @JsonProperty(index = 2)
    private UserBasicInfo user;
    
    @JsonProperty(index = 3)
    private OfficerBasicInfo officer;
    
    @JsonProperty(index = 4)
    private DepartmentBasicInfo department;
    
    @JsonProperty(index = 5)
    private TaskBasicInfo task;
    
    @JsonProperty(index = 6)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate appointmentDate;
    
    @JsonProperty(index = 7)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm")
    private LocalTime startTime;
    
    @JsonProperty(index = 8)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm")
    private LocalTime endTime;
    
    @JsonProperty(index = 9)
    private AppointmentStatus status;
    
    @JsonProperty(index = 10)
    private boolean urgencyFlag;
    
    @JsonProperty(index = 11)
    private String urgencyReason;
    
    @JsonProperty(index = 12)
    private String rejectionReason;
    
    @JsonProperty(index = 13)
    private String notes;
    
    @JsonProperty(index = 14)
    private List<String> transferHistory;
    
    @JsonProperty(index = 15)
    private List<OfficerBasicInfo> additionalOfficers;
    
    @JsonProperty(index = 16)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdDate;
    
    @JsonProperty(index = 17)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime lastModifiedDate;
    
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class UserBasicInfo {
        private Long id;
        private String firstname;
        private String lastname;
        private String email;
        private String contact;
    }
    
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class OfficerBasicInfo {
        private String id;
        private String position;
        private String employeeId;
        private UserBasicInfo user;
    }
    
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class DepartmentBasicInfo {
        private String id;
        private String name;
        private String location;
        private String contactEmail;
        private String contactPhone;
    }
    
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class TaskBasicInfo {
        private String id;
        private String title;
        private String taskType;
        private String priority;
        private AppointmentStatus status;
    }
}
