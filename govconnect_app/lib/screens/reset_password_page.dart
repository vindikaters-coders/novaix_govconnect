import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:govconnect_app/config/routes.dart';
import 'package:govconnect_app/widgets/custom_app_bar.dart';
import 'package:govconnect_app/widgets/custom_button.dart';
import 'package:govconnect_app/widgets/custom_input_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    // Handle reset password logic here
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    
    // Validation
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      print('Please fill all fields');
      return;
    }
    
    if (newPassword != confirmPassword) {
      print('Passwords do not match');
      return;
    }
    
    if (newPassword.length < 8) {
      print('Password must be at least 8 characters long');
      return;
    }
    
    print('Resetting password...');
    // Add your password reset logic here
    // Navigate to success screen or login screen after successful reset
  }

  void _handleBack() {
    context.go(AppRoutes.otpConfirmation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Reset Password',
        onBackPressed: _handleBack,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // Spacer to center content vertically
            Expanded(
              flex: 2,
              child: Container(),
            ),
            
            // Title
            Text(
              'Set a new password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C1C1E),
                letterSpacing: -0.4,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 16),
            
            // Description
            Text(
              'Create a strong password that is easy for you to remember and hard for others to guess.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8E8E93),
                height: 1.4,
                letterSpacing: -0.2,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 40),
            
            // New Password field
            CustomInputField(
              label: 'New Password',
              placeholder: 'Enter a new password',
              controller: _newPasswordController,
              isPassword: true,
            ),
            
            SizedBox(height: 30),
            
            // Confirm New Password field
            CustomInputField(
              label: 'Confirm New Password',
              placeholder: 'Confirm your new password',
              controller: _confirmPasswordController,
              isPassword: true,
            ),
            
            SizedBox(height: 40),
            
            // Reset Password button
            CustomButton(
              text: 'Reset Password',
              onPressed: _handleResetPassword,
              isPrimary: false,
              backgroundColor: Color(0xFF34C759), // Green color
            ),
            
            // Spacer to center content
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}