package com.novaix.govconnect_server.validator;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.regex.Pattern;

public class UserValidator {
    public static final String USER_VALIDATION_FAILED_ERROR = "User Validation Failed";

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    private static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z\\d])[A-Za-z\\d@$!%*?&]{8,}$";
    private static final Pattern PASSWORD_PATTERN = Pattern.compile(PASSWORD_REGEX);

    private UserValidator(){}

    public static boolean isValidateEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    public static boolean isValidatePassword(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }

    public static boolean isValidDob(LocalDate dob) {
        try {
            LocalDate today = LocalDate.now();
            LocalDate minDate = today.minusYears(6);

            return !dob.isAfter(minDate);
        } catch (DateTimeParseException e) {
            throw new DateTimeParseException("Invalid date format", dob.toString(), 0);
        }
    }
}
