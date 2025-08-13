import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:govconnect_app/config/routes.dart';
import 'package:govconnect_app/widgets/custom_button.dart';
import 'package:govconnect_app/widgets/custom_input_field.dart';
import 'package:govconnect_app/widgets/custom_text_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Handle login logic here
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    
    print('Login attempt: $email');
    // Add your authentication logic here
  }

  void _handleForgotPassword() {
    // Handle forgot password logic
    print('Forgot password pressed');
  }

  void _handleRegister() {
    context.go(AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              
              // Email or NIC field
              CustomInputField(
                label: 'Email or NIC',
                placeholder: 'Enter your email or NIC',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              
              SizedBox(height: 30),
              
              // Password field
              CustomInputField(
                label: 'Password',
                placeholder: 'Enter your password',
                controller: _passwordController,
                isPassword: true,
              ),
              
              SizedBox(height: 40),
              
              // Login button
              CustomButton(
                text: 'Log In',
                onPressed: _handleLogin,
                isPrimary: true,
              ),
              
              SizedBox(height: 20),
              
              // Forgot password link
              Center(
                child: CustomTextButton(
                  text: 'Forgot Password?',
                  onPressed: _handleForgotPassword,
                ),
              ),
              
              SizedBox(height: 8),
              
              // Register link
              Center(
                child: CustomTextButton(
                  text: "Don't have an account? Register here.",
                  onPressed: _handleRegister,
                ),
              ),
              
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
