package com.novaix.govconnect_server.dto;

import com.novaix.govconnect_server.common.Address;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Department {
    private Long id;
    private String name;
    private Address address;
    private String contact;
    private String email;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
