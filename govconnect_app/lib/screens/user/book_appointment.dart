import 'package:flutter/material.dart';

import 'book_officer.dart';
import 'booking_confirmation.dart';

class BookAppointmentPage extends StatefulWidget {
  final String office;
  final String service;
  final Officer officer;

  const BookAppointmentPage({
    super.key,
    required this.office,
    required this.service,
    required this.officer,
  });

  @override
  BookAppointmentPageState createState() => BookAppointmentPageState();
}

class BookAppointmentPageState extends State<BookAppointmentPage> {
  DateTime selectedDate = DateTime.now();
  String? selectedTimeSlot;

  final List<TimeSlot> timeSlots = [
    TimeSlot(time: '10:00 AM - 10:30 AM', isAvailable: true),
    TimeSlot(time: '10:30 AM - 11:00 AM', isAvailable: false),
    TimeSlot(time: '11:00 AM - 11:30 AM', isAvailable: true),
    TimeSlot(time: '11:30 AM - 12:00 PM', isAvailable: true),
    TimeSlot(time: '2:00 PM - 2:30 PM', isAvailable: true),
    TimeSlot(time: '2:30 PM - 3:00 PM', isAvailable: false),
    TimeSlot(time: '3:00 PM - 3:30 PM', isAvailable: true),
    TimeSlot(time: '3:30 PM - 4:00 PM', isAvailable: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Book Appointment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Selection
                  _buildSectionTitle('Select a Date'),
                  const SizedBox(height: 16),
                  _buildCalendar(),
                  const SizedBox(height: 32),

                  // Time Slot Selection
                  _buildSectionTitle('Select a Time Slot'),
                  const SizedBox(height: 16),
                  _buildTimeSlots(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // Confirm Button
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Month Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month - 1,
                      1,
                    );
                  });
                },
              ),
              Text(
                _getMonthYearString(selectedDate),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month + 1,
                      1,
                    );
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Days of Week Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                .map((day) => Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: Text(
                day,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ))
                .toList(),
          ),
          const SizedBox(height: 8),

          // Calendar Grid
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    // final lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    final startDate = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));

    return Column(
      children: List.generate(6, (weekIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (dayIndex) {
            final date = startDate.add(Duration(days: weekIndex * 7 + dayIndex));
            final isCurrentMonth = date.month == selectedDate.month;
            final isToday = _isSameDay(date, DateTime.now());
            final isSelected = _isSameDay(date, selectedDate);
            final isPastDate = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

            return GestureDetector(
              onTap: isCurrentMonth && !isPastDate ? () {
                setState(() {
                  selectedDate = date;
                  selectedTimeSlot = null; // Reset time slot when date changes
                });
              } : null,
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2196F3)
                      : (isToday ? const Color(0xFFE3F2FD) : Colors.transparent),
                  shape: BoxShape.circle,
                  border: isToday && !isSelected
                      ? Border.all(color: const Color(0xFF2196F3), width: 1)
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected || isToday ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected
                        ? Colors.white
                        : (isCurrentMonth
                        ? (isPastDate ? Colors.grey[400] : Colors.black87)
                        : Colors.grey[300]),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  Widget _buildTimeSlots() {
    return Column(
      children: timeSlots.map((timeSlot) => _buildTimeSlotCard(timeSlot)).toList(),
    );
  }

  Widget _buildTimeSlotCard(TimeSlot timeSlot) {
    final isSelected = selectedTimeSlot == timeSlot.time;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: timeSlot.isAvailable ? () {
          setState(() {
            selectedTimeSlot = timeSlot.time;
          });
        } : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: timeSlot.isAvailable
                ? (isSelected ? const Color(0xFFE8F5E8) : const Color(0xFFE8F5E8))
                : const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: timeSlot.isAvailable
                  ? (isSelected ? const Color(0xFF4CAF50) : const Color(0xFF4CAF50).withValues(alpha: 0.3))
                  : const Color(0xFFF44336).withValues(alpha: 0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Center(
            child: Text(
              timeSlot.time,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: timeSlot.isAvailable
                    ? (isSelected ? const Color(0xFF4CAF50) : const Color(0xFF4CAF50))
                    : const Color(0xFFF44336),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    final canConfirm = selectedTimeSlot != null;

    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: canConfirm ? _confirmBooking : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2196F3),
            disabledBackgroundColor: Colors.grey[300],
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            'Confirm Booking',
            style: TextStyle(
              color: canConfirm ? Colors.white : Colors.grey[600],
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  String _getMonthYearString(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _confirmBooking() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmationPage(
          officerName: widget.officer.name,
          officeName: widget.office,
          date: _formatDate(selectedDate),
          time: selectedTimeSlot!,
          service: widget.service,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// Time Slot Model
class TimeSlot {
  final String time;
  final bool isAvailable;

  TimeSlot({
    required this.time,
    required this.isAvailable,
  });
}

// Appointment Data Model
class AppointmentData {
  final String office;
  final String service;
  final Officer officer;
  final DateTime date;
  final String timeSlot;

  AppointmentData({
    required this.office,
    required this.service,
    required this.officer,
    required this.date,
    required this.timeSlot,
  });

  Map<String, dynamic> toJson() {
    return {
      'office': office,
      'service': service,
      'officer': officer.toJson(),
      'date': date.toIso8601String(),
      'timeSlot': timeSlot,
      'bookedAt': DateTime.now().toIso8601String(),
    };
  }
}