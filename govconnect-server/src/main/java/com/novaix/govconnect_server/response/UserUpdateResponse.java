package com.novaix.govconnect_server.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.novaix.govconnect_server.common.Address;
import com.novaix.govconnect_server.enums.Gender;
import com.novaix.govconnect_server.enums.Role;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserUpdateResponse {
    
    @JsonProperty(index = 1)
    private Long id;

    @JsonProperty(index = 2)
    private String firstName;

    @JsonProperty(index = 3)
    private String lastName;

    @JsonProperty(index = 4)
    private String phoneNumber;

    @JsonProperty(index = 5)
    private String email;

    @JsonProperty(index = 6)
    private Address address;

    @JsonProperty(index = 7)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDate dob;

    @JsonProperty(index = 8)
    private Gender gender;

    @JsonProperty(index = 9)
    private String nic;

    @JsonProperty(index = 10)
    private Role role;

    @JsonProperty(index = 11)
    private LocalDateTime updatedAt;
}
