import 'package:flutter/material.dart';

class BookingConfirmationPage extends StatelessWidget {
  final String officerName;
  final String officeName;
  final String date;
  final String time;
  final String service;

  const BookingConfirmationPage({
    super.key,
    required this.officerName,
    required this.officeName,
    required this.date,
    required this.time,
    required this.service,
  });

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
          'Booking Confirmed',
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Confirmation Title
                  const Text(
                    'Your Appointment is Confirmed!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Subtitle
                  const Text(
                    'We look forward to seeing you.\nA reminder will be sent 24 hours prior.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Appointment Details
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Officer:', officerName),
                        const SizedBox(height: 12),
                        _buildDetailRow('Office:', officeName),
                        const SizedBox(height: 12),
                        _buildDetailRow('Date:', date),
                        const SizedBox(height: 12),
                        _buildDetailRow('Time:', time),
                        const SizedBox(height: 12),
                        _buildDetailRow('Service:', service),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  _buildActionButton(
                    'Add to Calendar',
                    const Color(0xFF2196F3),
                    Icons.calendar_today,
                        () => _addToCalendar(context),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    'Call Officer',
                    const Color(0xFF616161),
                    Icons.phone,
                        () => _callOfficer(context),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    'Back to Home',
                    const Color(0xFF616161),
                    null,
                        () => _backToHome(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
      String text,
      Color backgroundColor,
      IconData? icon,
      VoidCallback onPressed,
      ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCalendar(BuildContext context) {
    // Here you would integrate with device calendar
    // For now, show a confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment added to calendar!'),
        backgroundColor: Color(0xFF4CAF50),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _callOfficer(BuildContext context) {
    // Here you would implement calling functionality
    // For now, show a dialog with officer contact info
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Contact $officerName'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phone: +94 11 234 5678'),
              SizedBox(height: 8),
              Text('Extension: 1234'),
              SizedBox(height: 8),
              Text('Office Hours: 8:00 AM - 4:30 PM'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement actual calling here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Calling officer...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: const Text(
                'Call Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _backToHome(BuildContext context) {
    // Navigate back to dashboard/home
    Navigator.of(context).popUntil((route) => route.isFirst);
    // If using GoRouter, use: context.go('/dashboard');
  }
}

// Factory method to create confirmation page from appointment data
class BookingConfirmationFactory {
  static Widget fromAppointmentData({
    required String officerName,
    required String officeName,
    required DateTime date,
    required String timeSlot,
    required String service,
  }) {
    return BookingConfirmationPage(
      officerName: officerName,
      officeName: officeName,
      date: _formatDate(date),
      time: timeSlot,
      service: service,
    );
  }

  static String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// Enhanced version with additional features
class EnhancedBookingConfirmationPage extends StatefulWidget {
  final AppointmentConfirmationData appointmentData;

  const EnhancedBookingConfirmationPage({
    super.key,
    required this.appointmentData,
  });

  @override
  EnhancedBookingConfirmationPageState createState() =>
      EnhancedBookingConfirmationPageState();
}

class EnhancedBookingConfirmationPageState
    extends State<EnhancedBookingConfirmationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
          'Booking Confirmed',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Success Icon
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Confirmation Title
                    const Text(
                      'Your Appointment is Confirmed!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Subtitle
                    const Text(
                      'We look forward to seeing you.\nA reminder will be sent 24 hours prior.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Appointment Details Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Officer:', widget.appointmentData.officerName),
                          const SizedBox(height: 12),
                          _buildDetailRow('Office:', widget.appointmentData.officeName),
                          const SizedBox(height: 12),
                          _buildDetailRow('Date:', widget.appointmentData.date),
                          const SizedBox(height: 12),
                          _buildDetailRow('Time:', widget.appointmentData.time),
                          const SizedBox(height: 12),
                          _buildDetailRow('Service:', widget.appointmentData.service),
                          const SizedBox(height: 16),
                          _buildDetailRow('Reference ID:', widget.appointmentData.referenceId),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Action Buttons
                    _buildActionButton(
                      'Add to Calendar',
                      const Color(0xFF2196F3),
                      Icons.calendar_today,
                          () => _addToCalendar(context),
                    ),
                    const SizedBox(height: 12),
                    _buildActionButton(
                      'Call Officer',
                      const Color(0xFF616161),
                      Icons.phone,
                          () => _callOfficer(context),
                    ),
                    const SizedBox(height: 12),
                    _buildActionButton(
                      'Back to Home',
                      const Color(0xFF616161),
                      null,
                          () => _backToHome(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
      String text,
      Color backgroundColor,
      IconData? icon,
      VoidCallback onPressed,
      ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCalendar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Appointment added to calendar!'),
          ],
        ),
        backgroundColor: Color(0xFF4CAF50),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _callOfficer(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Contact ${widget.appointmentData.officerName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phone: ${widget.appointmentData.officerPhone}'),
              const SizedBox(height: 8),
              Text('Extension: ${widget.appointmentData.officerExtension}'),
              const SizedBox(height: 8),
              const Text('Office Hours: 8:00 AM - 4:30 PM'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Calling officer...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: const Text(
                'Call Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _backToHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

// Appointment confirmation data model
class AppointmentConfirmationData {
  final String officerName;
  final String officeName;
  final String date;
  final String time;
  final String service;
  final String referenceId;
  final String officerPhone;
  final String officerExtension;

  AppointmentConfirmationData({
    required this.officerName,
    required this.officeName,
    required this.date,
    required this.time,
    required this.service,
    required this.referenceId,
    required this.officerPhone,
    required this.officerExtension,
  });
}