package com.novaix.govconnect_server.dto;

import com.novaix.govconnect_server.enums.TaskStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Task {
    private Long id;
    private String name;
    private TaskStatus status;
    private String statusDetails;
}
