package com.novaix.govconnect_server.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserRegistrationRequest {
    @NotBlank(message = "First name cannot be blank")
    private String firstname;

    @NotBlank(message = "Last name cannot be blank")
    private String lastname;

    @NotBlank(message = "Contact cannot be blank")
    @Pattern(regexp = "\\d{10}", message = "Contact must be 10 digits long")
    private String contact;

    @NotBlank(message = "Email cannot be blank")
    @Email(message = "Invalid Email Address")
    private String email;

    @NotBlank(message = "Password cannot be null")
    @Pattern(regexp = ".{8,}", message = "Password must be at least 8 characters long")
    private String password;

    @NotBlank(message = "Address cannot be blank")
    private String address;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    @Past(message = "Date of Birth must be in the past")
    @NotNull(message = "Date of Birth cannot be null")
    private LocalDate dob;

    @NotBlank(message = "Gender cannot be blank")
    private String gender;

    @NotBlank(message = "Nic cannot be blank")
    private String nic;
}
