// New Statistic Item component
import 'package:flutter/material.dart';

class StatisticItem extends StatelessWidget {
  final String title;
  final String value;

  const StatisticItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8E8E93),
            letterSpacing: -0.1,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}