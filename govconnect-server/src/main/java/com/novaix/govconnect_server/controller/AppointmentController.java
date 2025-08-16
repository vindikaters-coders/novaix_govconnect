package com.novaix.govconnect_server.controller;

import com.novaix.govconnect_server.request.AppointmentActionRequestDTO;
import com.novaix.govconnect_server.request.AppointmentRequestDTO;
import com.novaix.govconnect_server.response.AppointmentResponseDTO;
import com.novaix.govconnect_server.service.appointment.AppointmentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/appointments")
@RequiredArgsConstructor
@Slf4j
public class AppointmentController {

    private final AppointmentService appointmentService;

    @PostMapping
    public ResponseEntity<AppointmentResponseDTO> createAppointment(
            @Valid @RequestBody AppointmentRequestDTO request,
            @AuthenticationPrincipal UserDetails userDetails) {
        
        log.info("Create appointment request from user: {}", userDetails.getUsername());
        AppointmentResponseDTO response = appointmentService.createAppointment(request, userDetails.getUsername());
        return ResponseEntity.status(201).body(response);
    }

    @GetMapping("/my")
    public ResponseEntity<List<AppointmentResponseDTO>> getUserAppointments(
            @AuthenticationPrincipal UserDetails userDetails) {
        
        log.info("Get user appointments request from: {}", userDetails.getUsername());
        List<AppointmentResponseDTO> appointments = appointmentService.getUserAppointments(userDetails.getUsername());
        return ResponseEntity.ok(appointments);
    }

    @GetMapping("/assigned")
    public ResponseEntity<List<AppointmentResponseDTO>> getOfficerAppointments(
            @AuthenticationPrincipal UserDetails userDetails) {
        
        log.info("Get officer appointments request from: {}", userDetails.getUsername());
        List<AppointmentResponseDTO> appointments = appointmentService.getOfficerAppointments(userDetails.getUsername());
        return ResponseEntity.ok(appointments);
    }

    @PutMapping("/{id}/accept")
    public ResponseEntity<AppointmentResponseDTO> acceptAppointment(
            @PathVariable String id,
            @Valid @RequestBody AppointmentActionRequestDTO request,
            @AuthenticationPrincipal UserDetails userDetails) {
        
        log.info("Accept appointment {} request from officer: {}", id, userDetails.getUsername());
        AppointmentResponseDTO response = appointmentService.acceptAppointment(id, request, userDetails.getUsername());
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}/reject")
    public ResponseEntity<AppointmentResponseDTO> rejectAppointment(
            @PathVariable String id,
            @Valid @RequestBody AppointmentActionRequestDTO request,
            @AuthenticationPrincipal UserDetails userDetails) {
        
        log.info("Reject appointment {} request from officer: {}", id, userDetails.getUsername());
        AppointmentResponseDTO response = appointmentService.rejectAppointment(id, request, userDetails.getUsername());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<AppointmentResponseDTO> getAppointmentById(
            @PathVariable String id,
            @AuthenticationPrincipal UserDetails userDetails) {
        
        log.info("Get appointment {} request from user: {}", id, userDetails.getUsername());
        AppointmentResponseDTO response = appointmentService.getAppointmentById(id, userDetails.getUsername());
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}")
    public ResponseEntity<AppointmentResponseDTO> updateAppointment(
            @PathVariable String id,
            @Valid @RequestBody AppointmentRequestDTO request,
            @AuthenticationPrincipal UserDetails userDetails) {
        
        log.info("Update appointment {} request from user: {}", id, userDetails.getUsername());
        AppointmentResponseDTO response = appointmentService.updateAppointment(id, request, userDetails.getUsername());
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> cancelAppointment(
            @PathVariable String id,
            @AuthenticationPrincipal UserDetails userDetails) {
        
        log.info("Cancel appointment {} request from user: {}", id, userDetails.getUsername());
        appointmentService.cancelAppointment(id, userDetails.getUsername());
        return ResponseEntity.noContent().build();
    }
}
