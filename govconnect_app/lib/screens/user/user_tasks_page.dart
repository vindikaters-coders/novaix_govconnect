import 'package:flutter/material.dart';
import 'package:govconnect_app/screens/user/user_task_details.dart';

class UserTasksPage extends StatelessWidget {
  const UserTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        title: const Text(
          'My Tasks',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildTaskCard(
            context,
            title: 'Birth Certificate Application',
            department: 'Registrar General\'s Office (AG Office)',
            officer: 'Mr. S. Perera',
            statusDetails: 'Awaiting document verification.',
            status: TaskStatus.inProgress,
            addedDate: '2025-08-10 at 14:30',
            // Pass a unique ID to identify the task type
            taskId: 'birth_certificate',
          ),
          const SizedBox(height: 16),
          _buildTaskCard(
            context,
            title: 'Police Report for Address Change',
            department: 'Police Station - Fort Branch',
            officer: 'Officer R. Bandara',
            statusDetails: 'Report issued and collected.',
            status: TaskStatus.completed,
            addedDate: '2025-08-05 at 10:00',
            // Pass a unique ID
            taskId: 'police_report',
          ),
          const SizedBox(height: 16),
          _buildTaskCard(
            context,
            title: 'Pension Scheme Inquiry',
            department: 'Department of Pensions',
            officer: 'Ms. L. Jayasuriya',
            statusDetails: 'Appointment pending for clarification.',
            status: TaskStatus.pending,
            addedDate: '2025-07-28 at 09:15',
            // No specific detail page, so it will use the generic one
            taskId: 'pension_inquiry',
          ),
          const SizedBox(height: 16),
          _buildTaskCard(
            context,
            title: 'Vehicle Registration Transfer',
            department: 'Department of Motor Traffic',
            officer: 'Mr. N. Samarawickrama',
            statusDetails: 'Additional documentation requested.',
            status: TaskStatus.onHold,
            addedDate: '2025-08-12 at 16:00',
            taskId: 'vehicle_registration',
          ),
          const SizedBox(height: 16),
          _buildTaskCard(
            context,
            title: 'Medical Certificate Request',
            department: 'Ministry of Health - Public Clinic',
            officer: 'Dr. K. Fernando',
            statusDetails: 'Request denied, re-application advised.',
            status: TaskStatus.rejected,
            addedDate: '2025-08-08 at 11:20',
            taskId: 'medical_certificate',
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(
      BuildContext context, {
        required String title,
        required String department,
        required String officer,
        required String statusDetails,
        required TaskStatus status,
        required String addedDate,
        required String taskId, // Added taskId to identify the task
      }) {
    final statusConfig = _getStatusConfig(status);

    return GestureDetector(
      onTap: () {
        // Use the navigation helper to go to the detail page
        TaskNavigation.navigateToTaskDetail(context, taskId, title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: statusConfig.borderColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Status Badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusConfig.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statusConfig.label,
                      style: TextStyle(
                        color: statusConfig.textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Department
              _buildInfoRow('Department:', department),
              const SizedBox(height: 6),

              // Officer
              _buildInfoRow('Officer:', officer),
              const SizedBox(height: 6),

              // Status Details
              _buildInfoRow('Status Details:', statusDetails),
              const SizedBox(height: 12),

              // Added Date
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Added: $addedDate',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  StatusConfig _getStatusConfig(TaskStatus status) {
    switch (status) {
      case TaskStatus.inProgress:
        return StatusConfig(
          label: 'In Progress',
          backgroundColor: const Color(0xFF2196F3),
          textColor: Colors.white,
          borderColor: const Color(0xFF2196F3),
        );
      case TaskStatus.completed:
        return StatusConfig(
          label: 'Completed',
          backgroundColor: const Color(0xFF4CAF50),
          textColor: Colors.white,
          borderColor: const Color(0xFF4CAF50),
        );
      case TaskStatus.pending:
        return StatusConfig(
          label: 'Pending',
          backgroundColor: const Color(0xFFFF9800),
          textColor: Colors.white,
          borderColor: const Color(0xFFFF9800),
        );
      case TaskStatus.onHold:
        return StatusConfig(
          label: 'On Hold',
          backgroundColor: const Color(0xFF9E9E9E),
          textColor: Colors.white,
          borderColor: const Color(0xFF9E9E9E),
        );
      case TaskStatus.rejected:
        return StatusConfig(
          label: 'Rejected',
          backgroundColor: const Color(0xFFF44336),
          textColor: Colors.white,
          borderColor: const Color(0xFFF44336),
        );
    }
  }
}

// Enums and Models
enum TaskStatus {
  inProgress,
  completed,
  pending,
  onHold,
  rejected,
}

class StatusConfig {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  StatusConfig({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });
}

// Task Model (for future use with real data)
class Task {
  final String id;
  final String title;
  final String department;
  final String officer;
  final String statusDetails;
  final TaskStatus status;
  final DateTime addedDate;

  Task({
    required this.id,
    required this.title,
    required this.department,
    required this.officer,
    required this.statusDetails,
    required this.status,
    required this.addedDate,
  });
}