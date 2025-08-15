package com.novaix.govconnect_server.dao;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "task_history")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class TransferHistoryDao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, name = "from_user_id")
    private Long from;

    @Column(nullable = false,name = "to_user_id")
    private Long to;

    @Column(nullable = false,name = "transfer_timestamp")
    private LocalDateTime timestamp;

    @Column(nullable = false)
    private String reason;
}
