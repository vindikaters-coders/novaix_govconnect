import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:govconnect_app/config/routes.dart';
import 'package:govconnect_app/widgets/custom_app_bar.dart';
import 'package:govconnect_app/widgets/custom_button.dart';
import 'package:govconnect_app/widgets/custom_dropdown_field.dart';
import 'package:govconnect_app/widgets/custom_input_field.dart';
import 'package:govconnect_app/widgets/custom_text_button.dart';

import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();

  final authService = AuthService();

  @override
  void dispose() {
    _nicController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return; // Stop if form is invalid
    }

    String nic = _nicController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String gender = _genderController.text.trim();
    String dob = _dobController.text.trim();
    String lastName = _lastNameController.text.trim();
    String firstName = _firstNameController.text.trim();
    String contactNumber = _contactNumberController.text.trim();
    String city = _addressController.text.trim();
    
    print(dob);

    try {
      final res = await authService.register(nic, email, password, lastName, firstName, city, dob, contactNumber, gender);

      if (res['statusCode'] == 201) {
        context.go(AppRoutes.login);
      }
    } catch (e) {
      print("Registration error: ${e.toString()}");
    }
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
        child: Form(
          key: _formKey, // ✅ Form wrapper
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              CustomInputField(
                label: 'NIC Number',
                placeholder: 'Enter your NIC Number',
                controller: _nicController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "NIC is required";
                  }
                  if (value.length < 10) {
                    return "Invalid NIC number";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              CustomInputField(
                label: 'Email Address',
                placeholder: 'Enter your email address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              CustomInputField(
                label: 'First Name',
                placeholder: 'Enter your first name',
                controller: _firstNameController,
                validator: (value) =>
                (value == null || value.isEmpty) ? "First name required" : null,
              ),

              const SizedBox(height: 30),

              CustomInputField(
                label: 'Last Name',
                placeholder: 'Enter your last name',
                controller: _lastNameController,
                validator: (value) =>
                (value == null || value.isEmpty) ? "Last name required" : null,
              ),

              const SizedBox(height: 30),

              CustomInputField(
                label: 'Date of Birth',
                placeholder: 'Select your DOB',
                controller: _dobController,
                isDate: true,
                validator: (value) =>
                (value == null || value.isEmpty) ? "DOB is required" : null,
              ),

              const SizedBox(height: 30),

              CustomInputField(
                label: 'City',
                placeholder: 'Enter city you live',
                controller: _addressController,
                validator: (value) =>
                (value == null || value.isEmpty) ? "City required" : null,
              ),

              const SizedBox(height: 30),

              CustomInputField(
                label: 'Phone Number',
                placeholder: 'Enter your phone number',
                controller: _contactNumberController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone number required";
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return "Enter valid 10-digit phone number";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              CustomDropdownField(
                label: 'Gender',
                hintText: 'Select gender',
                value: _genderController.text.isEmpty ? null : _genderController.text,
                items: ['MALE', 'FEMALE'],
                onChanged: (value) {
                  if (value != null) {
                    _genderController.text = value;
                  }
                },
              ),

              const SizedBox(height: 30),

              CustomInputField(
                label: 'Password',
                placeholder: 'Create a password',
                controller: _passwordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              CustomInputField(
                label: 'Confirm Password',
                placeholder: 'Confirm your password',
                controller: _confirmPasswordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm your password";
                  }
                  if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 40),

              CustomButton(
                text: 'Register Account',
                onPressed: _handleRegister,
                isPrimary: false,
                backgroundColor: const Color(0xFF34C759),
              ),

              const SizedBox(height: 20),

              Center(
                child: CustomTextButton(
                  text: 'Already have an account? Log in here.',
                  onPressed: _handleLoginRedirect,
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
