import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool isPassword;
  final bool isDate;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isRequired;

  const CustomInputField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.isPassword = false,
    this.isDate = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isRequired = false,
  });

  @override
  CustomInputFieldState createState() => CustomInputFieldState();
}

class CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1C1E),
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType:
            widget.isDate ? TextInputType.none : widget.keyboardType,
            obscureText: widget.isPassword ? _obscureText : false,
            readOnly: widget.isDate, // prevent manual typing for date
            onTap: widget.isDate
                ? () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                String formattedDate =
                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                widget.controller.text = formattedDate;
              }
            }
                : null,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF1C1C1E),
              letterSpacing: -0.2,
            ),
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xFF8E8E93),
                letterSpacing: -0.2,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: const Color(0xFF8E8E93),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
                  : widget.isDate
                  ? const Icon(Icons.calendar_today,
                  size: 20, color: Color(0xFF8E8E93))
                  : null,
            ),
            validator: (value) {
              if (widget.isRequired && (value == null || value.isEmpty)) {
                return "${widget.label} is required";
              }
              if (widget.validator != null) {
                return widget.validator!(value);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
