package com.novaix.govconnect_server.service.appointment;

import com.novaix.govconnect_server.request.AppointmentActionRequestDTO;
import com.novaix.govconnect_server.request.AppointmentRequestDTO;
import com.novaix.govconnect_server.response.AppointmentResponseDTO;

import java.util.List;

public interface AppointmentService {
    
    AppointmentResponseDTO createAppointment(AppointmentRequestDTO request, String authenticatedUserEmail);
    List<AppointmentResponseDTO> getUserAppointments(String authenticatedUserEmail);
    
    List<AppointmentResponseDTO> getOfficerAppointments(String authenticatedUserEmail);
    AppointmentResponseDTO acceptAppointment(String appointmentId, AppointmentActionRequestDTO request, String authenticatedUserEmail);
    AppointmentResponseDTO rejectAppointment(String appointmentId, AppointmentActionRequestDTO request, String authenticatedUserEmail);
    
    AppointmentResponseDTO getAppointmentById(String appointmentId, String authenticatedUserEmail);
    AppointmentResponseDTO updateAppointment(String appointmentId, AppointmentRequestDTO request, String authenticatedUserEmail);
    void cancelAppointment(String appointmentId, String authenticatedUserEmail);
}
