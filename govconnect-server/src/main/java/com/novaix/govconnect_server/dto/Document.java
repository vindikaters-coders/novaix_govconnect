package com.novaix.govconnect_server.dto;

import com.novaix.govconnect_server.enums.DocumentStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Document {
    private Long id;
    private String name;
    private String url;
    private String mimeType;
    private String documentType;
    private DocumentStatus status;
}
