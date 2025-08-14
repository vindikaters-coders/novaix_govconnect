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

    @NotBlank(message = "Town cannot be blank")
    @Column(nullable = false)
    private String town;

    @NotBlank(message = "Province cannot be blank")
    @Column(nullable = false)
    private String province;

    private String streetAddress;
}
