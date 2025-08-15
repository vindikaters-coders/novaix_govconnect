package com.novaix.govconnect_server.request;

import lombok.*;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ClientRegistrationRequest extends UserRegistrationRequest{
    private String postalCode;
}
