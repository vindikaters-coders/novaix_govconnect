package com.novaix.govconnect_server.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Notification {
    private Long id;
    private String title;
    private String body;
    private String type;
    private Boolean isRead;
}
