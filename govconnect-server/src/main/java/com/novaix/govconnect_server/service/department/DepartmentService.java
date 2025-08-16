package com.novaix.govconnect_server.service.department;

import com.novaix.govconnect_server.request.DepartmentCreateRequest;
import com.novaix.govconnect_server.request.DepartmentUpdateRequest;
import com.novaix.govconnect_server.response.DepartmentListResponse;
import com.novaix.govconnect_server.response.DepartmentResponse;

public interface DepartmentService {
    
    DepartmentResponse createDepartment(DepartmentCreateRequest request);
    
    DepartmentResponse getDepartmentById(String departmentId);
    
    DepartmentResponse getDepartmentByName(String name);
    
    DepartmentListResponse getAllDepartments();
    
    DepartmentResponse updateDepartment(String departmentId, DepartmentUpdateRequest request);
    
    void deleteDepartment(String departmentId);
}
