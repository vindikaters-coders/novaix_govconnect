import 'package:flutter/material.dart';

class OfficerDashboard extends StatefulWidget {
  const OfficerDashboard({super.key});

  @override
  OfficerDashboardState createState() => OfficerDashboardState();
}

class OfficerDashboardState extends State<OfficerDashboard> {
  final OfficerProfile officer = OfficerProfile(
    name: 'Mr. R. Gamage',
    title: 'Grama Niladari Officer',
    department: 'Registrar General\'s Office',
    employeeId: 'GN001',
    status: OfficerStatus.inOffice,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        title: const Text(
          'Officer Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Officer Profile Card
            _buildOfficerProfileCard(),
            const SizedBox(height: 20),

            // Quick Stats Overview
            _buildQuickStats(),
            const SizedBox(height: 20),

            // Today's Appointments Section
            _buildTodaysAppointments(),
            const SizedBox(height: 20),

            // Pending Tasks Section
            _buildPendingTasks(),
            const SizedBox(height: 20),

            // Quick Actions
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficerProfileCard() {
    return Container(
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
      child: Row(
        children: [
          // Officer Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                officer.name.split(' ').map((n) => n[0]).take(2).join(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Officer Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  officer.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  officer.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'ID: ${officer.employeeId}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(officer.status),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              _getStatusText(officer.status),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Today\'s\nAppointments',
            value: '8',
            color: const Color(0xFF2196F3),
            icon: Icons.calendar_today,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Pending\nTasks',
            value: '12',
            color: const Color(0xFFFF9800),
            icon: Icons.pending_actions,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Completed\nToday',
            value: '6',
            color: const Color(0xFF4CAF50),
            icon: Icons.check_circle,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
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
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysAppointments() {
    final appointments = [
      Appointment(
        time: '10:00 AM',
        clientName: 'Sanath Nandasiri',
        service: 'Birth Certificate Request',
        status: AppointmentStatus.scheduled,
      ),
      Appointment(
        time: '11:30 AM',
        clientName: 'Suneera Sumanga',
        service: 'Address Change',
        status: AppointmentStatus.scheduled,
      ),
      Appointment(
        time: '2:00 PM',
        clientName: 'Kamal Perera',
        service: 'Marriage Certificate',
        status: AppointmentStatus.completed,
      ),
      Appointment(
        time: '3:30 PM',
        clientName: 'Nimal Silva',
        service: 'Document Verification',
        status: AppointmentStatus.inProgress,
      ),
    ];

    return _buildSection(
      title: 'Today\'s Appointments',
      children: appointments.map((appointment) =>
          _buildAppointmentCard(appointment)
      ).toList(),
    );
  }

  Widget _buildPendingTasks() {
    final tasks = [
      PendingTask(
        taskId: '#123',
        title: 'Review Document',
        requestedBy: 'Roshan Ranil',
        priority: TaskPriority.high,
        dueDate: 'Today',
      ),
      PendingTask(
        taskId: '#124',
        title: 'Approve Letter',
        requestedBy: 'Mary Lee',
        priority: TaskPriority.medium,
        dueDate: 'Tomorrow',
      ),
      PendingTask(
        taskId: '#125',
        title: 'Verify Identity',
        requestedBy: 'John Fernando',
        priority: TaskPriority.low,
        dueDate: 'Aug 18',
      ),
    ];

    return _buildSection(
      title: 'Pending Tasks',
      children: tasks.map((task) => _buildTaskCard(task)).toList(),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Create\nAppointment',
                Icons.calendar_today,
                const Color(0xFF2196F3),
                    () => _createAppointment(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Review\nDocuments',
                Icons.description,
                const Color(0xFFFF9800),
                    () => _reviewDocuments(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Send\nNotification',
                Icons.notifications,
                const Color(0xFF4CAF50),
                    () => _sendNotification(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Generate\nReport',
                Icons.assessment,
                const Color(0xFF9C27B0),
                    () => _generateReport(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getAppointmentStatusColor(appointment.status).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      appointment.time,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '- ${appointment.clientName}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Service: ${appointment.service}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getAppointmentStatusColor(appointment.status),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _getAppointmentStatusText(appointment.status),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(PendingTask task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getPriorityColor(task.priority).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${task.title} - Task ${task.taskId}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Requested by: ${task.requestedBy}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Due: ${task.dueDate}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getPriorityText(task.priority),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _handleTask(task),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  minimumSize: Size.zero,
                ),
                child: const Text(
                  'Review',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String title,
      IconData icon,
      Color color,
      VoidCallback onPressed,
      ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(OfficerStatus status) {
    switch (status) {
      case OfficerStatus.inOffice:
        return const Color(0xFF4CAF50);
      case OfficerStatus.onBreak:
        return const Color(0xFFFF9800);
      case OfficerStatus.unavailable:
        return const Color(0xFFF44336);
    }
  }

  String _getStatusText(OfficerStatus status) {
    switch (status) {
      case OfficerStatus.inOffice:
        return 'In Office';
      case OfficerStatus.onBreak:
        return 'On Break';
      case OfficerStatus.unavailable:
        return 'Unavailable';
    }
  }

  Color _getAppointmentStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.scheduled:
        return const Color(0xFF2196F3);
      case AppointmentStatus.inProgress:
        return const Color(0xFFFF9800);
      case AppointmentStatus.completed:
        return const Color(0xFF4CAF50);
      case AppointmentStatus.cancelled:
        return const Color(0xFFF44336);
    }
  }

  String _getAppointmentStatusText(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.scheduled:
        return 'Scheduled';
      case AppointmentStatus.inProgress:
        return 'In Progress';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return const Color(0xFFF44336);
      case TaskPriority.medium:
        return const Color(0xFFFF9800);
      case TaskPriority.low:
        return const Color(0xFF4CAF50);
    }
  }

  String _getPriorityText(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }

  // Action Methods
  void _createAppointment() {
    // Navigate to create appointment page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create Appointment clicked')),
    );
  }

  void _reviewDocuments() {
    // Navigate to document review page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review Documents clicked')),
    );
  }

  void _sendNotification() {
    // Navigate to send notification page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Send Notification clicked')),
    );
  }

  void _generateReport() {
    // Navigate to report generation page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Generate Report clicked')),
    );
  }

  void _handleTask(PendingTask task) {
    // Navigate to task details page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reviewing task ${task.taskId}')),
    );
  }
}

// Data Models
class OfficerProfile {
  final String name;
  final String title;
  final String department;
  final String employeeId;
  final OfficerStatus status;

  OfficerProfile({
    required this.name,
    required this.title,
    required this.department,
    required this.employeeId,
    required this.status,
  });
}

class Appointment {
  final String time;
  final String clientName;
  final String service;
  final AppointmentStatus status;

  Appointment({
    required this.time,
    required this.clientName,
    required this.service,
    required this.status,
  });
}

class PendingTask {
  final String taskId;
  final String title;
  final String requestedBy;
  final TaskPriority priority;
  final String dueDate;

  PendingTask({
    required this.taskId,
    required this.title,
    required this.requestedBy,
    required this.priority,
    required this.dueDate,
  });
}

// Enums
enum OfficerStatus { inOffice, onBreak, unavailable }
enum AppointmentStatus { scheduled, inProgress, completed, cancelled }
enum TaskPriority { high, medium, low }