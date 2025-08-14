// lib/screens/notifications_page.dart
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  NotificationsPageState createState() => NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      type: NotificationType.success,
      title: 'Appointment Confirmed!',
      message: 'Your appointment with Officer Kamal Perera at the Grama Niladari Office on Aug 15, 2025, at 10:00 AM is confirmed.',
      timestamp: '2 hours ago',
    ),
    NotificationItem(
      type: NotificationType.alert,
      title: 'Action Required: Missing Document',
      message: 'You need to submit your Parent\'s Marriage Certificate for your Birth Certificate application. Please upload it by Aug 14, 2025.',
      timestamp: 'Yesterday',
    ),
    NotificationItem(
      type: NotificationType.info,
      title: 'Task Status Update',
      message: 'Your "Certification" task for the Birth Certificate workflow has been approved by the Grama Niladari Office.',
      timestamp: '2 days ago',
    ),
    NotificationItem(
      type: NotificationType.warning,
      title: 'Upcoming Appointment Reminder',
      message: 'Don\'t forget your appointment with the Registrar General\'s Office tomorrow, Aug 14, 2025, at 2:00 PM.',
      timestamp: '3 days ago',
    ),
    NotificationItem(
      type: NotificationType.message,
      title: 'New Message from Officer',
      message: 'Officer Silva has sent you a message regarding your recent inquiry. Check your Communication Hub.',
      timestamp: '1 week ago',
    ),
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
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'mark_all_read') {
                _markAllAsRead();
              } else if (value == 'clear_all') {
                _clearAllNotifications();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'mark_all_read',
                child: Text('Mark all as read'),
              ),
              const PopupMenuItem<String>(
                value: 'clear_all',
                child: Text('Clear all notifications'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Section Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: const Text(
              'Your Latest Updates',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Notifications List
          Expanded(
            child: notifications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(notifications[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Colored left border
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: _getNotificationColor(notification.type),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),

            // Notification content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getNotificationColor(notification.type).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getNotificationIcon(notification.type),
                        color: _getNotificationColor(notification.type),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            notification.message,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              notification.timestamp,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We\'ll notify you when there are updates',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return const Color(0xFF4CAF50);
      case NotificationType.alert:
        return const Color(0xFFF44336);
      case NotificationType.info:
        return const Color(0xFF2196F3);
      case NotificationType.warning:
        return const Color(0xFFFF9800);
      case NotificationType.message:
        return const Color(0xFF2196F3);
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Icons.check_circle;
      case NotificationType.alert:
        return Icons.error;
      case NotificationType.info:
        return Icons.info;
      case NotificationType.warning:
        return Icons.warning;
      case NotificationType.message:
        return Icons.mail;
    }
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Notifications'),
          content: const Text('Are you sure you want to clear all notifications? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  notifications.clear();
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All notifications cleared'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF44336),
              ),
              child: const Text(
                'Clear All',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Notification Models and Enums
enum NotificationType {
  success,
  alert,
  info,
  warning,
  message,
}

class NotificationItem {
  final NotificationType type;
  final String title;
  final String message;
  final String timestamp;
  bool isRead;
  final String? actionUrl;
  final Map<String, dynamic>? metadata;

  NotificationItem({
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.actionUrl,
    this.metadata,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      type: NotificationType.values.firstWhere(
            (e) => e.toString() == 'NotificationType.${json['type']}',
        orElse: () => NotificationType.info,
      ),
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
      isRead: json['isRead'] ?? false,
      actionUrl: json['actionUrl'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString().split('.').last,
      'title': title,
      'message': message,
      'timestamp': timestamp,
      'isRead': isRead,
      'actionUrl': actionUrl,
      'metadata': metadata,
    };
  }
}

// Notification service for managing notifications
class NotificationService {
  static final List<NotificationItem> _notifications = [];
  static final List<Function(NotificationItem)> _listeners = [];

  static List<NotificationItem> get notifications => List.from(_notifications);

  static void addNotification(NotificationItem notification) {
    _notifications.insert(0, notification);
    for (var listener in _listeners) {
      listener(notification);
    }
  }

  static void markAsRead(int index) {
    if (index >= 0 && index < _notifications.length) {
      _notifications[index].isRead = true;
    }
  }

  static void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
  }

  static void removeNotification(int index) {
    if (index >= 0 && index < _notifications.length) {
      _notifications.removeAt(index);
    }
  }

  static void clearAll() {
    _notifications.clear();
  }

  static void addListener(Function(NotificationItem) listener) {
    _listeners.add(listener);
  }

  static void removeListener(Function(NotificationItem) listener) {
    _listeners.remove(listener);
  }

  static int get unreadCount {
    return _notifications.where((n) => !n.isRead).length;
  }

  // Factory methods for common notification types
  static NotificationItem createAppointmentConfirmation({
    required String officerName,
    required String office,
    required String date,
    required String time,
  }) {
    return NotificationItem(
      type: NotificationType.success,
      title: 'Appointment Confirmed!',
      message: 'Your appointment with $officerName at the $office on $date at $time is confirmed.',
      timestamp: 'Now',
    );
  }

  static NotificationItem createDocumentRequest({
    required String documentType,
    required String deadline,
  }) {
    return NotificationItem(
      type: NotificationType.alert,
      title: 'Action Required: Missing Document',
      message: 'You need to submit your $documentType. Please upload it by $deadline.',
      timestamp: 'Now',
    );
  }

  static NotificationItem createTaskUpdate({
    required String taskName,
    required String status,
    required String office,
  }) {
    return NotificationItem(
      type: NotificationType.info,
      title: 'Task Status Update',
      message: 'Your "$taskName" task has been $status by the $office.',
      timestamp: 'Now',
    );
  }

  static NotificationItem createAppointmentReminder({
    required String office,
    required String date,
    required String time,
  }) {
    return NotificationItem(
      type: NotificationType.warning,
      title: 'Upcoming Appointment Reminder',
      message: 'Don\'t forget your appointment with the $office on $date at $time.',
      timestamp: 'Now',
    );
  }

  static NotificationItem createOfficerMessage({
    required String officerName,
    required String subject,
  }) {
    return NotificationItem(
      type: NotificationType.message,
      title: 'New Message from Officer',
      message: 'Officer $officerName has sent you a message regarding $subject. Check your Communication Hub.',
      timestamp: 'Now',
    );
  }
}