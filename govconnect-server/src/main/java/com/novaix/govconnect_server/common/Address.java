package com.novaix.govconnect_server.common;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class Address {

    @NotBlank(message = "City cannot be blank")
    @Column(nullable = false)
    private String city;

    @Column(nullable = true)
    private String town;

    @Column(nullable = true)
    private String province;

    @Column(nullable = true)
    private String streetAddress;
}
