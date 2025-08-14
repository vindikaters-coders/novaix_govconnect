import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:govconnect_app/config/routes.dart';

class GovConnectWelcomeScreen extends StatelessWidget {
  const GovConnectWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              // Status bar space
              SizedBox(height: 60),
              
              // Spacer to center content
              Expanded(
                flex: 2,
                child: Container(),
              ),
              
              // Government building icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFF007AFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              
              SizedBox(height: 40),
              
              // Welcome title
              Text(
                'Welcome to GovConnect',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1C1E),
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 20),
              
              // Description text
              Text(
                'Your seamless portal to government services. Simplify your tasks, manage appointments, and connect with officers, all in one place.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8E8E93),
                  height: 1.4,
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
              ),
              
              // Spacer
              Expanded(
                flex: 2,
                child: Container(),
              ),
              
              // Log In button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(AppRoutes.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF007AFF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 12),
              
              // Create Account button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(AppRoutes.register);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF2F2F7),
                    foregroundColor: Color(0xFF1C1C1E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
              ),
              
              // Bottom spacer
              Expanded(
                flex: 1,
                child: Container(),
              ),
              
              // Footer text
              Text(
                'Powered by Public Services Authority',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8E8E93),
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}