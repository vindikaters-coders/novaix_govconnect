import 'package:flutter/material.dart';

import '../../widgets/feedback_popup.dart';

class UserTaskDetailPage extends StatelessWidget {
  final String taskTitle;
  final List<TaskStep> steps;

  const UserTaskDetailPage({
    super.key,
    required this.taskTitle,
    required this.steps,
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
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              // Handle help action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task Title
                  Text(
                    taskTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Timeline Steps
                  _buildTimeline(),

                  const SizedBox(height: 30),

                  // Feedback Section
                  _buildFeedbackSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isLast = index == steps.length - 1;

        return _buildTimelineItem(
          step: step,
          isLast: isLast,
        );
      }).toList(),
    );
  }

  Widget _buildTimelineItem({
    required TaskStep step,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: _getStepColor(step.status),
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(vertical: 4),
              ),
          ],
        ),
        const SizedBox(width: 16),

        // Step content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                step.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),

              // Status badge
              if (step.status != TaskStepStatus.pending)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStepColor(step.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusLabel(step.status),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              // Officer info (if available)
              if (step.officer != null) ...[
                const SizedBox(height: 6),
                Text(
                  'Officer: ${step.officer}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],

              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Had a recent appointment? We\'d love to hear your feedback!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                FeedbackHelper.showFeedbackPopup(
                  context: context,
                  officerName: 'John Doe',
                  appointmentDate: 'Aug 12, 2025',
                  serviceName: 'Birth Certificate Application',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Provide Feedback',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStepColor(TaskStepStatus status) {
    switch (status) {
      case TaskStepStatus.completed:
        return const Color(0xFF4CAF50);
      case TaskStepStatus.inProgress:
        return const Color(0xFFFF9800);
      case TaskStepStatus.pending:
        return Colors.grey[400]!;
    }
  }

  String _getStatusLabel(TaskStepStatus status) {
    switch (status) {
      case TaskStepStatus.completed:
        return 'Completed';
      case TaskStepStatus.inProgress:
        return 'In Progress';
      case TaskStepStatus.pending:
        return 'Pending';
    }
  }
}

// Enums and Models
enum TaskStepStatus {
  completed,
  inProgress,
  pending,
}

class TaskStep {
  final String title;
  final String description;
  final TaskStepStatus status;
  final String? officer;

  TaskStep({
    required this.title,
    required this.description,
    required this.status,
    this.officer,
  });
}

// Example usage with sample data
class BirthCertificateDetailPage extends StatelessWidget {
  const BirthCertificateDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final steps = [
      TaskStep(
        title: 'Visit Grama Niladari Office',
        description: 'Get a letter of confirmation.',
        status: TaskStepStatus.completed,
      ),
      TaskStep(
        title: 'Book Appointment with AG Office',
        description: 'Officer: Mr. S. Perera',
        status: TaskStepStatus.inProgress,
      ),
      TaskStep(
        title: 'Document Submission',
        description: 'Submit documents for final approval.',
        status: TaskStepStatus.pending,
      ),
    ];

    return UserTaskDetailPage(
      taskTitle: 'Birth Certificate Application',
      steps: steps,
    );
  }
}

// Factory method to create task detail pages
class TaskDetailPageFactory {
  static Widget createBirthCertificateDetailPage() {
    final steps = [
      TaskStep(
        title: 'Visit Grama Niladari Office',
        description: 'Get a letter of confirmation.',
        status: TaskStepStatus.completed,
      ),
      TaskStep(
        title: 'Book Appointment with AG Office',
        description: 'Officer: Mr. S. Perera',
        status: TaskStepStatus.inProgress,
      ),
      TaskStep(
        title: 'Document Submission',
        description: 'Submit documents for final approval.',
        status: TaskStepStatus.pending,
      ),
    ];

    return UserTaskDetailPage(
      taskTitle: 'Birth Certificate Application',
      steps: steps,
    );
  }

  static Widget createPoliceReportDetailPage() {
    final steps = [
      TaskStep(
        title: 'Visit Police Station',
        description: 'Submit initial application.',
        status: TaskStepStatus.completed,
        officer: 'Officer R. Bandara',
      ),
      TaskStep(
        title: 'Document Verification',
        description: 'Documents verified and processed.',
        status: TaskStepStatus.completed,
        officer: 'Officer R. Bandara',
      ),
      TaskStep(
        title: 'Report Collection',
        description: 'Report issued and collected.',
        status: TaskStepStatus.completed,
        officer: 'Officer R. Bandara',
      ),
    ];

    return UserTaskDetailPage(
      taskTitle: 'Police Report for Address Change',
      steps: steps,
    );
  }
}

// Navigation helper
class TaskNavigation {
  static void navigateToTaskDetail(
      BuildContext context,
      String taskId,
      String taskTitle,
      ) {
    Widget detailPage;

    // Route to appropriate detail page based on task type
    switch (taskId) {
      case 'birth_certificate':
        detailPage = TaskDetailPageFactory.createBirthCertificateDetailPage();
        break;
      case 'police_report':
        detailPage = TaskDetailPageFactory.createPoliceReportDetailPage();
        break;
      default:
      // Create a generic detail page
        detailPage = UserTaskDetailPage(
          taskTitle: taskTitle,
          steps: [
            TaskStep(
              title: 'Step 1',
              description: 'Initial step description.',
              status: TaskStepStatus.completed,
            ),
            TaskStep(
              title: 'Step 2',
              description: 'Current step in progress.',
              status: TaskStepStatus.inProgress,
            ),
            TaskStep(
              title: 'Step 3',
              description: 'Pending completion.',
              status: TaskStepStatus.pending,
            ),
          ],
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => detailPage),
    );
  }
}