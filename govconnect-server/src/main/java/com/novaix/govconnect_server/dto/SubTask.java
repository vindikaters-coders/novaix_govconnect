package com.novaix.govconnect_server.dto;

import com.novaix.govconnect_server.enums.SubTaskStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SubTask {
    private Long id;
    private String name;
    private SubTaskStatus status;
    private LocalDateTime dueDate;
}
