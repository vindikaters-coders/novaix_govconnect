package com.novaix.govconnect_server.controller;

import com.novaix.govconnect_server.request.DepartmentCreateRequest;
import com.novaix.govconnect_server.request.DepartmentUpdateRequest;
import com.novaix.govconnect_server.response.ApiResponse;
import com.novaix.govconnect_server.response.DepartmentListResponse;
import com.novaix.govconnect_server.response.DepartmentResponse;
import com.novaix.govconnect_server.service.department.DepartmentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/departments")
@RequiredArgsConstructor
@Slf4j
public class DepartmentController {

    private final DepartmentService departmentService;

    @PostMapping
    public ResponseEntity<ApiResponse> createDepartment(@Valid @RequestBody DepartmentCreateRequest request) {
        log.info("Received request to create department: {}", request.getName());
        
        DepartmentResponse response = departmentService.createDepartment(request);
        
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setMessage("Department created successfully");
        apiResponse.setData(response);
        
        return ResponseEntity.status(HttpStatus.CREATED).body(apiResponse);
    }

    @GetMapping("/{departmentId}")
    public ResponseEntity<ApiResponse> getDepartmentById(@PathVariable String departmentId) {
        log.info("Received request to fetch department with ID: {}", departmentId);
        
        DepartmentResponse response = departmentService.getDepartmentById(departmentId);
        
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setMessage("Department retrieved successfully");
        apiResponse.setData(response);
        
        return ResponseEntity.ok(apiResponse);
    }

    @GetMapping("/name/{name}")
    public ResponseEntity<ApiResponse> getDepartmentByName(@PathVariable String name) {
        log.info("Received request to fetch department with name: {}", name);
        
        DepartmentResponse response = departmentService.getDepartmentByName(name);
        
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setMessage("Department retrieved successfully");
        apiResponse.setData(response);
        
        return ResponseEntity.ok(apiResponse);
    }

    @GetMapping
    public ResponseEntity<ApiResponse> getAllDepartments() {
        log.info("Received request to fetch all departments");
        
        DepartmentListResponse response = departmentService.getAllDepartments();
        
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setMessage("Departments retrieved successfully");
        apiResponse.setData(response);
        
        return ResponseEntity.ok(apiResponse);
    }

    @PutMapping("/{departmentId}")
    public ResponseEntity<ApiResponse> updateDepartment(
            @PathVariable String departmentId,
            @Valid @RequestBody DepartmentUpdateRequest request) {
        log.info("Received request to update department with ID: {}", departmentId);
        
        DepartmentResponse response = departmentService.updateDepartment(departmentId, request);
        
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setMessage("Department updated successfully");
        apiResponse.setData(response);
        
        return ResponseEntity.ok(apiResponse);
    }

    @DeleteMapping("/{departmentId}")
    public ResponseEntity<ApiResponse> deleteDepartment(@PathVariable String departmentId) {
        log.info("Received request to delete department with ID: {}", departmentId);
        
        departmentService.deleteDepartment(departmentId);
        
        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setMessage("Department deleted successfully");
        apiResponse.setData(null);
        
        return ResponseEntity.ok(apiResponse);
    }
}
