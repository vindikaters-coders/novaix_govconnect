package com.novaix.govconnect_server.service.department.impl;

import com.novaix.govconnect_server.dao.DepartmentDao;
import com.novaix.govconnect_server.exception.custom.ResourceNotFoundException;
import com.novaix.govconnect_server.repository.DepartmentRepository;
import com.novaix.govconnect_server.request.DepartmentCreateRequest;
import com.novaix.govconnect_server.request.DepartmentUpdateRequest;
import com.novaix.govconnect_server.response.DepartmentListResponse;
import com.novaix.govconnect_server.response.DepartmentResponse;
import com.novaix.govconnect_server.service.department.DepartmentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class DepartmentServiceImpl implements DepartmentService {

    private final DepartmentRepository departmentRepository;
    private final ModelMapper modelMapper;

    @Override
    public DepartmentResponse createDepartment(DepartmentCreateRequest request) {
        log.info("Creating new department with name: {}", request.getName());

        if (departmentRepository.existsByName(request.getName())) {
            throw new IllegalArgumentException("Department with name '" + request.getName() + "' already exists");
        }
        
        DepartmentDao department = new DepartmentDao();
        department.setDepartmentId(generateDepartmentId());
        department.setName(request.getName());
        department.setAddress(request.getAddress());
        department.setContactEmail(request.getContactEmail());
        department.setContactPhone(request.getContactPhone());
        
        DepartmentDao savedDepartment = departmentRepository.save(department);
        log.info("Successfully created department with ID: {}", savedDepartment.getDepartmentId());
        
        return modelMapper.map(savedDepartment, DepartmentResponse.class);
    }

    @Override
    @Transactional(readOnly = true)
    public DepartmentResponse getDepartmentById(String departmentId) {
        log.info("Fetching department with ID: {}", departmentId);
        
        DepartmentDao department = departmentRepository.findById(departmentId)
                .orElseThrow(() -> new ResourceNotFoundException("Department not found with ID: " + departmentId));
        
        return modelMapper.map(department, DepartmentResponse.class);
    }

    @Override
    @Transactional(readOnly = true)
    public DepartmentResponse getDepartmentByName(String name) {
        log.info("Fetching department with name: {}", name);
        
        DepartmentDao department = departmentRepository.findByName(name)
                .orElseThrow(() -> new ResourceNotFoundException("Department not found with name: " + name));
        
        return modelMapper.map(department, DepartmentResponse.class);
    }

    @Override
    @Transactional(readOnly = true)
    public DepartmentListResponse getAllDepartments() {
        log.info("Fetching all departments");
        
        List<DepartmentDao> departments = departmentRepository.findAllByOrderByNameAsc();
        
        List<DepartmentResponse> departmentResponses = departments.stream()
                .map(dept -> modelMapper.map(dept, DepartmentResponse.class))
                .collect(Collectors.toList());
        
        DepartmentListResponse response = new DepartmentListResponse();
        response.setDepartments(departmentResponses);
        response.setTotalCount(departments.size());
        
        return response;
    }

    @Override
    public DepartmentResponse updateDepartment(String departmentId, DepartmentUpdateRequest request) {
        log.info("Updating department with ID: {}", departmentId);
        
        DepartmentDao department = departmentRepository.findById(departmentId)
                .orElseThrow(() -> new ResourceNotFoundException("Department not found with ID: " + departmentId));

        if (request.getName() != null && !request.getName().equals(department.getName())) {
            if (departmentRepository.existsByName(request.getName())) {
                throw new IllegalArgumentException("Department with name '" + request.getName() + "' already exists");
            }
            department.setName(request.getName());
        }
        
        if (request.getAddress() != null) {
            department.setAddress(request.getAddress());
        }
        
        if (request.getContactEmail() != null) {
            department.setContactEmail(request.getContactEmail());
        }
        
        if (request.getContactPhone() != null) {
            department.setContactPhone(request.getContactPhone());
        }
        
        DepartmentDao updatedDepartment = departmentRepository.save(department);
        log.info("Successfully updated department with ID: {}", departmentId);
        
        return modelMapper.map(updatedDepartment, DepartmentResponse.class);
    }

    @Override
    public void deleteDepartment(String departmentId) {
        log.info("Deleting department with ID: {}", departmentId);
        
        if (!departmentRepository.existsById(departmentId)) {
            throw new ResourceNotFoundException("Department not found with ID: " + departmentId);
        }
        
        departmentRepository.deleteById(departmentId);
        log.info("Successfully deleted department with ID: {}", departmentId);
    }

    private String generateDepartmentId() {
        return "DEPT_" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}
