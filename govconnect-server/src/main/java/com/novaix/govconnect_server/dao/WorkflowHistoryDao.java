package com.novaix.govconnect_server.dao;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "workflow_history")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class WorkflowHistoryDao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false,name = "change_description")
    private String change;

    @Column(nullable = false, name = "timestamp")
    private LocalDateTime timestamp;
}
