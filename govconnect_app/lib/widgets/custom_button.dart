
import 'package:flutter/material.dart';

// Enhanced CustomButton with backgroundColor option
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.backgroundColor,
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
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
          ),
        ),
      ),
    );
  }
}