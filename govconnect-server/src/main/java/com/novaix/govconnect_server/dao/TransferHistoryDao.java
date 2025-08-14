package com.novaix.govconnect_server.dao;

import jakarta.persistence.*;
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
public class TransferHistoryDao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long from;

    @Column(nullable = false)
    private Long to;

    @Column(nullable = false)
    private LocalDateTime timestamp;

    @Column(nullable = false)
    private String reason;
}
