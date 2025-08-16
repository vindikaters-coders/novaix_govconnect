package com.novaix.govconnect_server.request;

import com.novaix.govconnect_server.common.Address;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DepartmentUpdateRequest {
    
    private String name;

    @Valid
    private Address address;

    @Email(message = "Contact email must be a valid email address")
    private String contactEmail;

    @Pattern(regexp = "\\d{10}", message = "Contact phone must be 10 digits long")
    private String contactPhone;
}
