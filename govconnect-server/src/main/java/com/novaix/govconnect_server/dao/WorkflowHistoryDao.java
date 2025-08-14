package com.novaix.govconnect_server.dao;

import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class WorkflowHistoryDao {
    private Long id;
    private String change;
    private LocalDateTime timestamp;
}
