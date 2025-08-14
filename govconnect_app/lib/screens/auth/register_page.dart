import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:govconnect_app/config/routes.dart';
import 'package:govconnect_app/widgets/custom_app_bar.dart';
import 'package:govconnect_app/widgets/custom_button.dart';
import 'package:govconnect_app/widgets/custom_input_field.dart';
import 'package:govconnect_app/widgets/custom_text_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    _nicController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    // Handle registration logic here
    String nic = _nicController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    
    // Add validation logic
    if (password != confirmPassword) {
      // Show error - passwords don't match
      print('Passwords do not match');
      return;
    }
    
    print('Registration attempt: NIC: $nic, Email: $email');
    // Add your registration logic here
  }

  void _handleBackToLogin() {
    context.go(AppRoutes.login);
  }

  void _handleLoginRedirect() {
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Register',
        onBackPressed: _handleBackToLogin,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            
            // NIC Number field
            CustomInputField(
              label: 'NIC Number',
              placeholder: 'Enter your NIC Number',
              controller: _nicController,
              keyboardType: TextInputType.text,
            ),
            
            SizedBox(height: 30),
            
            // Email Address field
            CustomInputField(
              label: 'Email Address',
              placeholder: 'Enter your email address',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            
            SizedBox(height: 30),
            
            // Password field
            CustomInputField(
              label: 'Password',
              placeholder: 'Create a password',
              controller: _passwordController,
              isPassword: true,
            ),
            
            SizedBox(height: 30),
            
            // Confirm Password field
            CustomInputField(
              label: 'Confirm Password',
              placeholder: 'Confirm your password',
              controller: _confirmPasswordController,
              isPassword: true,
            ),
            
            SizedBox(height: 40),
            
            // Register button
            CustomButton(
              text: 'Register Account',
              onPressed: _handleRegister,
              isPrimary: false,
              backgroundColor: Color(0xFF34C759), // Green color
            ),
            
            SizedBox(height: 20),
            
            // Login redirect link
            Center(
              child: CustomTextButton(
                text: 'Already have an account? Log in here.',
                onPressed: _handleLoginRedirect,
              ),
            ),
            
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
