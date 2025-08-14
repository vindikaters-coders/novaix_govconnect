import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:govconnect_app/config/routes.dart';
import 'package:govconnect_app/widgets/custom_app_bar.dart';
import 'package:govconnect_app/widgets/custom_button.dart';
import 'package:govconnect_app/widgets/custom_text_button.dart';
import 'package:govconnect_app/widgets/otp_input_widget.dart';

class OTPConfirmationScreen extends StatefulWidget {
  final String email;
  
  const OTPConfirmationScreen({
    super.key,
    this.email = 'sanath****@email.com',
  });

  @override
  OTPConfirmationScreenState createState() => OTPConfirmationScreenState();
}

class OTPConfirmationScreenState extends State<OTPConfirmationScreen> {
  final List<TextEditingController> _otpControllers = 
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = 
      List.generate(6, (index) => FocusNode());
  
  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleVerify() {
    // Collect OTP from all fields
    String otp = _otpControllers.map((controller) => controller.text).join();
    
    if (otp.length != 6) {
      print('Please enter complete 6-digit OTP');
      return;
    }
    
    print('Verifying OTP: $otp');
    // Add your OTP verification logic here
    // Navigate to next screen (password reset or success) if needed
  }

  void _handleResendOTP() {
    // Handle resend OTP logic
    print('Resending OTP to: ${widget.email}');
    // Clear current OTP fields
    for (var controller in _otpControllers) {
      controller.clear();
    }
    // Focus on first field
    _focusNodes[0].requestFocus();
  }

  void _handleBack() {
    context.go(AppRoutes.forgotPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'OTP Confirmation',
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
              'Check your email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C1C1E),
                letterSpacing: -0.4,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 16),
            
            // Description with email
            Text(
              'We\'ve sent a 6-digit code to ${widget.email}. Please enter it below to continue.',
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
            
            // OTP Input Fields
            OTPInputWidget(
              controllers: _otpControllers,
              focusNodes: _focusNodes,
            ),
            
            SizedBox(height: 30),
            
            // Resend OTP and Verify buttons row
            Row(
              children: [
                // Resend OTP button
                Expanded(
                  flex: 2,
                  child: CustomTextButton(
                    text: 'Resend OTP',
                    onPressed: _handleResendOTP,
                  ),
                ),
                
                SizedBox(width: 16),
                
                // Verify & Continue button
                Expanded(
                  flex: 3,
                  child: CustomButton(
                    text: 'Verify & Continue',
                    onPressed: _handleVerify,
                    isPrimary: true,
                  ),
                ),
              ],
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

