
import 'package:flutter/material.dart';

// Enhanced CustomButton with backgroundColor option
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Color? backgroundColor;
  final Color textColor;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    Color textColor;
    
    if (backgroundColor != null) {
      buttonColor = backgroundColor!;
      textColor = Colors.white;
    } else {
      buttonColor = isPrimary ? Color(0xFF007AFF) : Color(0xFFF2F2F7);
      textColor = isPrimary ? Colors.white : Color(0xFF1C1C1E);
    }

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}