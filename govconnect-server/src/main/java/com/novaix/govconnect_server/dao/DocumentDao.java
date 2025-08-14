package com.novaix.govconnect_server.dao;

import com.novaix.govconnect_server.common.BaseAuditingEntity;
import com.novaix.govconnect_server.enums.DocumentStatus;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class DocumentDao extends BaseAuditingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String url;

    @Column(nullable = false)
    private String mimeType;

    @Column(nullable = false)
    private String documentType;

    @Enumerated(EnumType.STRING)
    private DocumentStatus status;
}
