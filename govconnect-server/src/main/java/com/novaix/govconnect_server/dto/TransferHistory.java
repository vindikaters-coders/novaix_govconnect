package com.novaix.govconnect_server.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TransferHistory {
    private Long id;
    private Long from;
    private Long to;
    private LocalDateTime timestamp;
    private String reason;
}
