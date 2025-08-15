package com.novaix.govconnect_server.dto.users_dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Client extends Users{
    private String postalCode;
}
