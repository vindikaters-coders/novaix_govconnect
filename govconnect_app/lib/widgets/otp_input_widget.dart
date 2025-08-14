// New OTP Input Widget for 6-digit code entry
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPInputWidget extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  const OTPInputWidget({
    super.key,
    required this.controllers,
    required this.focusNodes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 45,
          height: 55,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1C1C1E),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              counterText: '',
              fillColor: Color(0xFFF2F2F7),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Color(0xFF007AFF),
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                // Move to next field
                if (index < 5) {
                  focusNodes[index + 1].requestFocus();
                } else {
                  // Last field, unfocus
                  focusNodes[index].unfocus();
                }
              } else {
                // Move to previous field on backspace
                if (index > 0) {
                  focusNodes[index - 1].requestFocus();
                }
              }
            },
            onTap: () {
              // Clear the field when tapped
              controllers[index].selection = TextSelection.fromPosition(
                TextPosition(offset: controllers[index].text.length),
              );
            },
          ),
        );
      }),
    );
  }
}