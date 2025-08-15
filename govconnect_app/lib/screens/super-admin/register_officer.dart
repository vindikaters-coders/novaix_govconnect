// Main Register Officer Screen
import 'package:flutter/material.dart';
import 'package:govconnect_app/widgets/custom_app_bar.dart';
import 'package:govconnect_app/widgets/custom_button.dart';
import 'package:govconnect_app/widgets/custom_dropdown_field.dart';
import 'package:govconnect_app/widgets/custom_form_field.dart';

class RegisterNewOfficerScreen extends StatefulWidget {
  const RegisterNewOfficerScreen({super.key});

  @override
  State<RegisterNewOfficerScreen> createState() => RegisterNewOfficerScreenState();
}

class RegisterNewOfficerScreenState extends State<RegisterNewOfficerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _cityController = TextEditingController();
  final _townController = TextEditingController();
  final _postalCodeController = TextEditingController();
  
  String? _selectedOfficeType;
  String? _selectedProvince;
  bool _isLoading = false;
  
  final List<String> _officeTypes = [
    'Head Office',
    'Regional Office',
    'Branch Office',
    'Sub Office',
    'Service Center'
  ];
  
  final List<String> _provinces = [
    'Western Province',
    'Central Province',
    'Southern Province',
    'Northern Province',
    'Eastern Province',
    'North Western Province',
    'North Central Province',
    'Uva Province',
    'Sabaragamuwa Province'
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _employeeIdController.dispose();
    _cityController.dispose();
    _townController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Future<void> _registerOfficer() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
      
    if (_selectedOfficeType == null) {
      _showSnackBar('Please select an office type', Colors.red);
      return;
    }
    
    if (_selectedProvince == null) {
      _showSnackBar('Please select a province', Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Show success message
    _showSnackBar('Officer registered successfully!', Colors.green);
    
    // Clear form
    _clearForm();
  }

  void _clearForm() {
    _formKey.currentState!.reset();
    _fullNameController.clear();
    _emailController.clear();
    _employeeIdController.clear();
    _cityController.clear();
    _townController.clear();
    _postalCodeController.clear();
    setState(() {
      _selectedOfficeType = null;
      _selectedProvince = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2196F3),
      body: Column(
        children: [
          CustomAppBar(title: 'Register New Officer'),
          
          Expanded(
            child: FormContainer(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(24.0),
                  children: [
                    CustomTextFormField(
                      label: 'Full Name',
                      hintText: 'Enter officer\'s full name',
                      controller: _fullNameController,
                      validator: (value) => _validateRequired(value, 'Full Name'),
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      label: 'Email Address',
                      hintText: 'Enter officer\'s email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      label: 'Employee ID',
                      hintText: 'Enter employee ID',
                      controller: _employeeIdController,
                      validator: (value) => _validateRequired(value, 'Employee ID'),
                    ),
                    const SizedBox(height: 20),

                    CustomDropdownField(
                      label: 'Office',
                      hintText: 'Select Office Type',
                      value: _selectedOfficeType,
                      items: _officeTypes,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOfficeType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    CustomDropdownField(
                      label: 'Province',
                      hintText: 'Select Province',
                      value: _selectedProvince,
                      items: _provinces,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedProvince = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      label: 'City',
                      hintText: 'Enter city',
                      controller: _cityController,
                      validator: (value) => _validateRequired(value, 'City'),
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      label: 'Town',
                      hintText: 'Enter town',
                      controller: _townController,
                      validator: (value) => _validateRequired(value, 'Town'),
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      label: 'Postal Code',
                      hintText: 'Enter postal code',
                      controller: _postalCodeController,
                      keyboardType: TextInputType.number,
                      validator: (value) => _validateRequired(value, 'Postal Code'),
                    ),
                    const SizedBox(height: 32),

                    CustomButton(
                      text: 'Register Officer',
                      onPressed: _registerOfficer,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Form Container Widget
class FormContainer extends StatelessWidget {
  final Widget child;

  const FormContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: child,
    );
  }
}