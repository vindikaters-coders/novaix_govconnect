package com.novaix.govconnect_server.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class AdminRegistrationRequest extends UserRegistrationRequest{
    private String postalCode;
}
