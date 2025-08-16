package com.novaix.govconnect_server.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DepartmentListResponse {
    private List<DepartmentResponse> departments;
    private long totalCount;
}
