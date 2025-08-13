package com.novaix.govconnect_server.exeption;

import com.novaix.govconnect_server.exeption.custom.InternalServerErrorException;
import com.novaix.govconnect_server.exeption.custom.InvalidInputException;
import com.novaix.govconnect_server.exeption.custom.UnauthorizedException;
import com.novaix.govconnect_server.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
@SuppressWarnings("unused")
public class GlobalExceptionHandler {

    @ExceptionHandler(InternalServerErrorException.class)
    public ResponseEntity<ApiResponse> handleInternalServerError(InternalServerErrorException ex) {
        ApiResponse response = new ApiResponse(ex.getMessage(), null);
        return ResponseEntity.status(500).body(response);
    }

    @ExceptionHandler(UnauthorizedException.class)
    public ResponseEntity<ApiResponse> handleUnauthorized(UnauthorizedException ex){
        ApiResponse response = new ApiResponse(ex.getMessage(), null);
        return ResponseEntity.status(401).body(response);
    }

    @ExceptionHandler(InvalidInputException.class)
    public ResponseEntity<ApiResponse> handleInvalidInput(InvalidInputException ex){
        ApiResponse response = new ApiResponse(ex.getMessage(), null);
        return ResponseEntity.status(400).body(response);
    }
}
