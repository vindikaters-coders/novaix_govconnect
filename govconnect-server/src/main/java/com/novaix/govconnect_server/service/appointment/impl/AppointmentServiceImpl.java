package com.novaix.govconnect_server.service.appointment.impl;

import com.novaix.govconnect_server.dao.AppointmentDao;
import com.novaix.govconnect_server.dao.DepartmentDao;
import com.novaix.govconnect_server.dao.OfficerDao;
import com.novaix.govconnect_server.dao.TaskDao;
import com.novaix.govconnect_server.dao.UsersDao;
import com.novaix.govconnect_server.enums.AppointmentStatus;
import com.novaix.govconnect_server.enums.Role;
import com.novaix.govconnect_server.exception.custom.ForbiddenException;
import com.novaix.govconnect_server.exception.custom.InvalidInputException;
import com.novaix.govconnect_server.exception.custom.ResourceNotFoundException;
import com.novaix.govconnect_server.repository.AppointmentRepository;
import com.novaix.govconnect_server.repository.DepartmentRepository;
import com.novaix.govconnect_server.repository.OfficerRepository;
import com.novaix.govconnect_server.repository.TaskRepository;
import com.novaix.govconnect_server.repository.UserRepository;
import com.novaix.govconnect_server.request.AppointmentActionRequestDTO;
import com.novaix.govconnect_server.request.AppointmentRequestDTO;
import com.novaix.govconnect_server.response.AppointmentResponseDTO;
import com.novaix.govconnect_server.service.appointment.AppointmentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class AppointmentServiceImpl implements AppointmentService {
    
    private final AppointmentRepository appointmentRepository;
    private final UserRepository userRepository;
    private final OfficerRepository officerRepository;
    private final DepartmentRepository departmentRepository;
    private final TaskRepository taskRepository;
    
    @Override
    public AppointmentResponseDTO createAppointment(AppointmentRequestDTO request, String authenticatedUserEmail) {
        log.info("Creating appointment for user: {}", authenticatedUserEmail);
        
        UsersDao user = getUserByEmail(authenticatedUserEmail);
        
        if (user.getRole() != Role.ROLE_USER) {
            throw new ForbiddenException("Only users can create appointments");
        }
        
        TaskDao task = getTaskById(request.getTaskId());
        OfficerDao officer = getOfficerById(request.getOfficerId());
        DepartmentDao department = getDepartmentById(request.getDepartmentId());
        
        if (!task.getUser().getId().equals(user.getId())) {
            throw new ForbiddenException("You can only create appointments for your own tasks");
        }
        
        validateAppointmentTime(request.getAppointmentDate(), request.getStartTime(), request.getEndTime());
        
        validateTimeConflicts(officer, request.getAppointmentDate(), request.getStartTime(), request.getEndTime());
        
        AppointmentDao appointment = new AppointmentDao();
        appointment.setUser(user);
        appointment.setOfficer(officer);
        appointment.setDepartment(department);
        appointment.setTask(task);
        appointment.setAppointmentDate(request.getAppointmentDate());
        appointment.setStartTime(request.getStartTime());
        appointment.setEndTime(request.getEndTime());
        appointment.setStatus(AppointmentStatus.BOOKED);
        appointment.setUrgencyFlag(request.isUrgencyFlag());
        appointment.setUrgencyReason(request.getUrgencyReason());
        appointment.setNotes(request.getNotes());
        appointment.setTransferHistory(new ArrayList<>());
        appointment.setAdditionalOfficers(new ArrayList<>());
        
        AppointmentDao savedAppointment = appointmentRepository.save(appointment);
        log.info("Appointment created successfully with ID: {}", savedAppointment.getId());
        
        return mapToResponseDTO(savedAppointment);
    }
    
    @Override
    public List<AppointmentResponseDTO> getUserAppointments(String authenticatedUserEmail) {
        log.info("Fetching appointments for user: {}", authenticatedUserEmail);
        
        UsersDao user = getUserByEmail(authenticatedUserEmail);
        
        if (user.getRole() != Role.ROLE_USER) {
            throw new ForbiddenException("Only users can view their own appointments");
        }
        
        List<AppointmentDao> appointments = appointmentRepository.findByUserOrderByAppointmentDateDesc(user);
        return appointments.stream()
                .map(this::mapToResponseDTO)
                .toList();
    }
    
    @Override
    public List<AppointmentResponseDTO> getOfficerAppointments(String authenticatedUserEmail) {
        log.info("Fetching appointments for officer: {}", authenticatedUserEmail);
        
        UsersDao user = getUserByEmail(authenticatedUserEmail);
        
        if (user.getRole() != Role.ROLE_ADMIN) {
            throw new ForbiddenException("Only officers can view assigned appointments");
        }
        
        Optional<OfficerDao> officerOpt = officerRepository.findByUser(user);
        if (officerOpt.isEmpty()) {
            throw new ResourceNotFoundException("Officer profile not found for user: " + authenticatedUserEmail);
        }
        
        OfficerDao officer = officerOpt.get();
        List<AppointmentDao> appointments = appointmentRepository.findByOfficerOrderByAppointmentDateDesc(officer);
        return appointments.stream()
                .map(this::mapToResponseDTO)
                .toList();
    }
    
    @Override
    public AppointmentResponseDTO acceptAppointment(String appointmentId, AppointmentActionRequestDTO request, String authenticatedUserEmail) {
        log.info("Officer {} accepting appointment {}", authenticatedUserEmail, appointmentId);
        
        AppointmentDao appointment = getAppointmentById(appointmentId);
        OfficerDao officer = getOfficerByEmail(authenticatedUserEmail);
        
        if (!appointment.getOfficer().getId().equals(officer.getId())) {
            throw new ForbiddenException("You can only accept appointments assigned to you");
        }
        
        if (appointment.getStatus() != AppointmentStatus.BOOKED) {
            throw new InvalidInputException("Only booked appointments can be accepted");
        }
        
        appointment.setStatus(AppointmentStatus.CONFIRMED);
        if (request.getNotes() != null && !request.getNotes().trim().isEmpty()) {
            appointment.setNotes(appointment.getNotes() + "\n[Officer Acceptance]: " + request.getNotes());
        }
        
        AppointmentDao savedAppointment = appointmentRepository.save(appointment);
        log.info("Appointment {} accepted successfully", appointmentId);
        
        return mapToResponseDTO(savedAppointment);
    }
    
    @Override
    public AppointmentResponseDTO rejectAppointment(String appointmentId, AppointmentActionRequestDTO request, String authenticatedUserEmail) {
        log.info("Officer {} rejecting appointment {}", authenticatedUserEmail, appointmentId);
        
        AppointmentDao appointment = getAppointmentById(appointmentId);
        OfficerDao officer = getOfficerByEmail(authenticatedUserEmail);
        
        if (!appointment.getOfficer().getId().equals(officer.getId())) {
            throw new ForbiddenException("You can only reject appointments assigned to you");
        }
        
        if (appointment.getStatus() == AppointmentStatus.COMPLETED || appointment.getStatus() == AppointmentStatus.CANCELLED) {
            throw new InvalidInputException("Cannot reject completed or cancelled appointments");
        }
        
        appointment.setStatus(AppointmentStatus.REJECTED);
        appointment.setRejectionReason(request.getReason());
        if (request.getNotes() != null && !request.getNotes().trim().isEmpty()) {
            appointment.setNotes(appointment.getNotes() + "\n[Officer Rejection]: " + request.getNotes());
        }
        
        AppointmentDao savedAppointment = appointmentRepository.save(appointment);
        log.info("Appointment {} rejected successfully", appointmentId);
        
        return mapToResponseDTO(savedAppointment);
    }
    
    @Override
    public AppointmentResponseDTO getAppointmentById(String appointmentId, String authenticatedUserEmail) {
        log.info("Fetching appointment {} for user {}", appointmentId, authenticatedUserEmail);
        
        AppointmentDao appointment = getAppointmentById(appointmentId);
        UsersDao user = getUserByEmail(authenticatedUserEmail);
        
        validateAppointmentAccess(appointment, user);
        
        return mapToResponseDTO(appointment);
    }
    
    @Override
    public AppointmentResponseDTO updateAppointment(String appointmentId, AppointmentRequestDTO request, String authenticatedUserEmail) {
        log.info("Updating appointment {} by user {}", appointmentId, authenticatedUserEmail);
        
        AppointmentDao appointment = getAppointmentById(appointmentId);
        UsersDao user = getUserByEmail(authenticatedUserEmail);
        
        if (!appointment.getUser().getId().equals(user.getId())) {
            throw new ForbiddenException("You can only update your own appointments");
        }
        
        if (appointment.getStatus() != AppointmentStatus.BOOKED) {
            throw new InvalidInputException("Only booked appointments can be updated");
        }
        
        if (!appointment.getAppointmentDate().equals(request.getAppointmentDate()) ||
            !appointment.getStartTime().equals(request.getStartTime()) ||
            !appointment.getEndTime().equals(request.getEndTime())) {
            
            validateAppointmentTime(request.getAppointmentDate(), request.getStartTime(), request.getEndTime());
            validateTimeConflicts(appointment.getOfficer(), request.getAppointmentDate(), 
                                request.getStartTime(), request.getEndTime(), appointmentId);
        }
        
        appointment.setAppointmentDate(request.getAppointmentDate());
        appointment.setStartTime(request.getStartTime());
        appointment.setEndTime(request.getEndTime());
        appointment.setUrgencyFlag(request.isUrgencyFlag());
        appointment.setUrgencyReason(request.getUrgencyReason());
        appointment.setNotes(request.getNotes());
        appointment.setStatus(AppointmentStatus.RESCHEDULED);
        
        AppointmentDao savedAppointment = appointmentRepository.save(appointment);
        log.info("Appointment {} updated successfully", appointmentId);
        
        return mapToResponseDTO(savedAppointment);
    }
    
    @Override
    public void cancelAppointment(String appointmentId, String authenticatedUserEmail) {
        log.info("Cancelling appointment {} by user {}", appointmentId, authenticatedUserEmail);
        
        AppointmentDao appointment = getAppointmentById(appointmentId);
        UsersDao user = getUserByEmail(authenticatedUserEmail);
        
        if (!appointment.getUser().getId().equals(user.getId())) {
            throw new ForbiddenException("You can only cancel your own appointments");
        }
        
        if (appointment.getStatus() == AppointmentStatus.COMPLETED) {
            throw new InvalidInputException("Cannot cancel completed appointments");
        }
        
        appointment.setStatus(AppointmentStatus.CANCELLED);
        appointmentRepository.save(appointment);
        log.info("Appointment {} cancelled successfully", appointmentId);
    }
    
    private UsersDao getUserByEmail(String email) {
        UsersDao user = userRepository.findByEmail(email);
        if (user == null) {
            throw new ResourceNotFoundException("User not found with email: " + email);
        }
        return user;
    }
    
    private OfficerDao getOfficerByEmail(String email) {
        UsersDao user = getUserByEmail(email);
        if (user.getRole() != Role.ROLE_ADMIN) {
            throw new ForbiddenException("User is not an officer");
        }
        
        Optional<OfficerDao> officerOpt = officerRepository.findByUser(user);
        if (officerOpt.isEmpty()) {
            throw new ResourceNotFoundException("Officer profile not found for user: " + email);
        }
        return officerOpt.get();
    }
    
    private AppointmentDao getAppointmentById(String appointmentId) {
        Optional<AppointmentDao> appointmentOpt = appointmentRepository.findById(appointmentId);
        if (appointmentOpt.isEmpty()) {
            throw new ResourceNotFoundException("Appointment not found with ID: " + appointmentId);
        }
        return appointmentOpt.get();
    }
    
    private TaskDao getTaskById(String taskId) {
        Optional<TaskDao> taskOpt = taskRepository.findById(taskId);
        if (taskOpt.isEmpty()) {
            throw new ResourceNotFoundException("Task not found with ID: " + taskId);
        }
        return taskOpt.get();
    }
    
    private OfficerDao getOfficerById(String officerId) {
        Optional<OfficerDao> officerOpt = officerRepository.findById(officerId);
        if (officerOpt.isEmpty()) {
            throw new ResourceNotFoundException("Officer not found with ID: " + officerId);
        }
        return officerOpt.get();
    }
    
    private DepartmentDao getDepartmentById(String departmentId) {
        Optional<DepartmentDao> departmentOpt = departmentRepository.findById(departmentId);
        if (departmentOpt.isEmpty()) {
            throw new ResourceNotFoundException("Department not found with ID: " + departmentId);
        }
        return departmentOpt.get();
    }
    
    private void validateAppointmentTime(LocalDate appointmentDate, LocalTime startTime, LocalTime endTime) {
        if (appointmentDate.isBefore(LocalDate.now()) || 
            (appointmentDate.equals(LocalDate.now()) && startTime.isBefore(LocalTime.now()))) {
            throw new InvalidInputException("Appointment must be scheduled for a future date and time");
        }
        
        if (!endTime.isAfter(startTime)) {
            throw new InvalidInputException("End time must be after start time");
        }
        
        if (startTime.isBefore(LocalTime.of(9, 0)) || endTime.isAfter(LocalTime.of(17, 0))) {
            throw new InvalidInputException("Appointments must be scheduled between 9:00 AM and 5:00 PM");
        }
    }
    
    private void validateTimeConflicts(OfficerDao officer, LocalDate appointmentDate, 
                                     LocalTime startTime, LocalTime endTime) {
        validateTimeConflicts(officer, appointmentDate, startTime, endTime, null);
    }
    
    private void validateTimeConflicts(OfficerDao officer, LocalDate appointmentDate, 
                                     LocalTime startTime, LocalTime endTime, String excludeAppointmentId) {
        List<AppointmentDao> existingAppointments = appointmentRepository
                .findByDateAndOfficerAndNotCancelledOrRejected(appointmentDate, officer);
        
        for (AppointmentDao existing : existingAppointments) {
            if (excludeAppointmentId != null && existing.getId().equals(excludeAppointmentId)) {
                continue;
            }
            
            if (!(endTime.isBefore(existing.getStartTime()) || startTime.isAfter(existing.getEndTime()))) {
                throw new InvalidInputException("The requested time slot conflicts with an existing appointment");
            }
        }
    }
    
    private void validateAppointmentAccess(AppointmentDao appointment, UsersDao user) {
        if (appointment.getUser().getId().equals(user.getId())) {
            return;
        }
        
        if (user.getRole() == Role.ROLE_ADMIN) {
            Optional<OfficerDao> officerOpt = officerRepository.findByUser(user);
            if (officerOpt.isPresent() && appointment.getOfficer().getId().equals(officerOpt.get().getId())) {
                return;
            }
        }
        
        if (user.getRole() == Role.ROLE_SUPERADMIN) {
            return;
        }
        
        throw new ForbiddenException("You don't have permission to access this appointment");
    }
    
    private AppointmentResponseDTO mapToResponseDTO(AppointmentDao appointment) {
        AppointmentResponseDTO response = new AppointmentResponseDTO();
        
        response.setId(appointment.getId());
        response.setAppointmentDate(appointment.getAppointmentDate());
        response.setStartTime(appointment.getStartTime());
        response.setEndTime(appointment.getEndTime());
        response.setStatus(appointment.getStatus());
        response.setUrgencyFlag(appointment.isUrgencyFlag());
        response.setUrgencyReason(appointment.getUrgencyReason());
        response.setRejectionReason(appointment.getRejectionReason());
        response.setNotes(appointment.getNotes());
        response.setTransferHistory(appointment.getTransferHistory());
        response.setCreatedDate(appointment.getCreatedDate());
        response.setLastModifiedDate(appointment.getLastModifiedDate());
        
        UsersDao user = appointment.getUser();
        AppointmentResponseDTO.UserBasicInfo userInfo = new AppointmentResponseDTO.UserBasicInfo();
        userInfo.setId(user.getId());
        userInfo.setFirstname(user.getFirstname());
        userInfo.setLastname(user.getLastname());
        userInfo.setEmail(user.getEmail());
        userInfo.setContact(user.getContact());
        response.setUser(userInfo);
        
        OfficerDao officer = appointment.getOfficer();
        AppointmentResponseDTO.OfficerBasicInfo officerInfo = new AppointmentResponseDTO.OfficerBasicInfo();
        officerInfo.setId(officer.getId());
        officerInfo.setPosition(officer.getPosition());
        officerInfo.setEmployeeId(officer.getEmployeeId());
        
        AppointmentResponseDTO.UserBasicInfo officerUserInfo = new AppointmentResponseDTO.UserBasicInfo();
        officerUserInfo.setId(officer.getUser().getId());
        officerUserInfo.setFirstname(officer.getUser().getFirstname());
        officerUserInfo.setLastname(officer.getUser().getLastname());
        officerUserInfo.setEmail(officer.getUser().getEmail());
        officerUserInfo.setContact(officer.getUser().getContact());
        officerInfo.setUser(officerUserInfo);
        response.setOfficer(officerInfo);
        
        DepartmentDao department = appointment.getDepartment();
        AppointmentResponseDTO.DepartmentBasicInfo departmentInfo = new AppointmentResponseDTO.DepartmentBasicInfo();
        departmentInfo.setId(department.getId());
        departmentInfo.setName(department.getName());
        departmentInfo.setLocation(department.getLocation());
        departmentInfo.setContactEmail(department.getContactEmail());
        departmentInfo.setContactPhone(department.getContactPhone());
        response.setDepartment(departmentInfo);
        
        TaskDao task = appointment.getTask();
        AppointmentResponseDTO.TaskBasicInfo taskInfo = new AppointmentResponseDTO.TaskBasicInfo();
        taskInfo.setId(task.getId());
        taskInfo.setTitle(task.getTitle());
        taskInfo.setTaskType(task.getTaskType());
        taskInfo.setPriority(task.getPriority());
        taskInfo.setStatus(task.getStatus());
        response.setTask(taskInfo);
        
        if (appointment.getAdditionalOfficers() != null) {
            List<AppointmentResponseDTO.OfficerBasicInfo> additionalOfficers = new ArrayList<>();
            for (OfficerDao additionalOfficer : appointment.getAdditionalOfficers()) {
                AppointmentResponseDTO.OfficerBasicInfo additionalInfo = new AppointmentResponseDTO.OfficerBasicInfo();
                additionalInfo.setId(additionalOfficer.getId());
                additionalInfo.setPosition(additionalOfficer.getPosition());
                additionalInfo.setEmployeeId(additionalOfficer.getEmployeeId());
                
                AppointmentResponseDTO.UserBasicInfo additionalUserInfo = new AppointmentResponseDTO.UserBasicInfo();
                additionalUserInfo.setId(additionalOfficer.getUser().getId());
                additionalUserInfo.setFirstname(additionalOfficer.getUser().getFirstname());
                additionalUserInfo.setLastname(additionalOfficer.getUser().getLastname());
                additionalUserInfo.setEmail(additionalOfficer.getUser().getEmail());
                additionalUserInfo.setContact(additionalOfficer.getUser().getContact());
                additionalInfo.setUser(additionalUserInfo);
                
                additionalOfficers.add(additionalInfo);
            }
            response.setAdditionalOfficers(additionalOfficers);
        }
        
        return response;
    }
}
