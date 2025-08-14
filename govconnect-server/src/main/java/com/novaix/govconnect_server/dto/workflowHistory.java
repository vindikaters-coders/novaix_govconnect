package com.novaix.govconnect_server.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class workflowHistory {
    private Long id;
    private String change;
    private LocalDateTime timestamp;
}
