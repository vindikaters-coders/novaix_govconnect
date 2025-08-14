import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:govconnect_app/config/routes.dart';
import 'package:govconnect_app/widgets/custom_app_bar.dart';
import 'package:govconnect_app/widgets/custom_button.dart';
import 'package:govconnect_app/widgets/custom_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendOTP() {
    // Handle send OTP logic here
    String email = _emailController.text.trim();
    
    if (email.isEmpty) {
      print('Please enter email or NIC');
      return;
    }
    
    print('Sending OTP to: $email');
    // Add your OTP sending logic here
    // Navigate to OTP verification screen if needed
  }

  void _handleBack() {
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Forgot Password',
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
              'Forgot your password?',
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
              'Enter your email address to receive a one-time password (OTP) to reset your password.',
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
            
            // Email or NIC input field
            CustomInputField(
              label: 'Email or NIC Number',
              placeholder: 'Enter your email or NIC Number',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            
            SizedBox(height: 30),
            
            // Send OTP button
            CustomButton(
              text: 'Send OTP',
              onPressed: _handleSendOTP,
              isPrimary: true,
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