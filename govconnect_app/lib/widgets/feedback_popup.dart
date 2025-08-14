import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FeedbackPopup extends StatefulWidget {
  final String officerName;
  final String appointmentDate;
  final String serviceName;
  final Function(FeedbackData)? onSubmit;

  const FeedbackPopup({
    super.key,
    required this.officerName,
    required this.appointmentDate,
    required this.serviceName,
    this.onSubmit,
  });

  @override
  FeedbackPopupState createState() => FeedbackPopupState();
}

class FeedbackPopupState extends State<FeedbackPopup> {
  int selectedRating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              'Rate Your Experience',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Officer and service info
            Text(
              'Appointment with Officer ${widget.officerName}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2196F3),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(
              'Date: ${widget.appointmentDate} | Service: ${widget.serviceName}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Star rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRating = index + 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      selectedRating > index ? Icons.star : Icons.star_outline,
                      size: 36,
                      color: selectedRating > index
                          ? const Color(0xFFFFD700)
                          : Colors.grey[400],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Feedback text field
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Share your detailed feedback here...',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF2196F3)),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedRating > 0 ? _submitFeedback : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  disabledBackgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Submit Feedback',
                  style: TextStyle(
                    color: selectedRating > 0 ? Colors.white : Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitFeedback() {
    final feedbackData = FeedbackData(
      rating: selectedRating,
      comment: _feedbackController.text.trim(),
      officerName: widget.officerName,
      appointmentDate: widget.appointmentDate,
      serviceName: widget.serviceName,
    );

    if (widget.onSubmit != null) {
      widget.onSubmit!(feedbackData);
    }

    Navigator.of(context).pop();

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you for your feedback!'),
        backgroundColor: Color(0xFF4CAF50),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

// Feedback data model
class FeedbackData {
  final int rating;
  final String comment;
  final String officerName;
  final String appointmentDate;
  final String serviceName;

  FeedbackData({
    required this.rating,
    required this.comment,
    required this.officerName,
    required this.appointmentDate,
    required this.serviceName,
  });

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'officerName': officerName,
      'appointmentDate': appointmentDate,
      'serviceName': serviceName,
      'submittedAt': DateTime.now().toIso8601String(),
    };
  }
}

// Helper class to show the feedback popup
class FeedbackHelper {
  static void showFeedbackPopup({
    required BuildContext context,
    required String officerName,
    required String appointmentDate,
    required String serviceName,
    Function(FeedbackData)? onSubmit,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return FeedbackPopup(
          officerName: officerName,
          appointmentDate: appointmentDate,
          serviceName: serviceName,
          onSubmit: onSubmit,
        );
      },
    );
  }
}

// Enhanced feedback popup with additional features
class EnhancedFeedbackPopup extends StatefulWidget {
  final String officerName;
  final String appointmentDate;
  final String serviceName;
  final Function(FeedbackData)? onSubmit;
  final String? initialComment;
  final int? initialRating;

  const EnhancedFeedbackPopup({
    super.key,
    required this.officerName,
    required this.appointmentDate,
    required this.serviceName,
    this.onSubmit,
    this.initialComment,
    this.initialRating,
  });

  @override
  EnhancedFeedbackPopupState createState() => EnhancedFeedbackPopupState();
}

class EnhancedFeedbackPopupState extends State<EnhancedFeedbackPopup>
    with SingleTickerProviderStateMixin {
  late int selectedRating;
  late TextEditingController _feedbackController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    selectedRating = widget.initialRating ?? 0;
    _feedbackController = TextEditingController(text: widget.initialComment ?? '');

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    color: Colors.grey[400],
                    size: 24,
                  ),
                ),
              ),

              // Title
              const Text(
                'Rate Your Experience',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Officer and service info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      'Appointment with Officer ${widget.officerName}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2196F3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date: ${widget.appointmentDate}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Service: ${widget.serviceName}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Star rating with labels
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              selectedRating > index ? Icons.star : Icons.star_outline,
                              size: selectedRating > index ? 40 : 36,
                              color: selectedRating > index
                                  ? const Color(0xFFFFD700)
                                  : Colors.grey[400],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getRatingLabel(selectedRating),
                    style: TextStyle(
                      fontSize: 14,
                      color: selectedRating > 0 ? const Color(0xFF2196F3) : Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Feedback text field
              TextField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Share your detailed feedback here...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF2196F3)),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: selectedRating > 0 ? _submitFeedback : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        disabledBackgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Submit Feedback',
                        style: TextStyle(
                          color: selectedRating > 0 ? Colors.white : Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent';
      default:
        return 'Please rate your experience';
    }
  }

  void _submitFeedback() {
    final feedbackData = FeedbackData(
      rating: selectedRating,
      comment: _feedbackController.text.trim(),
      officerName: widget.officerName,
      appointmentDate: widget.appointmentDate,
      serviceName: widget.serviceName,
    );

    if (widget.onSubmit != null) {
      widget.onSubmit!(feedbackData);
    }

    Navigator.of(context).pop();

    // Show animated success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            const Text('Thank you for your feedback!'),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

// Example usage in your task detail page
class TaskDetailPageExample {
  static void showFeedbackDialog(BuildContext context) {
    FeedbackHelper.showFeedbackPopup(
      context: context,
      officerName: 'John Doe',
      appointmentDate: 'Aug 12, 2025',
      serviceName: 'Birth Certificate Application',
      onSubmit: (feedbackData) {
        // Handle feedback submission
        if (kDebugMode) {
          print('Feedback submitted: ${feedbackData.toJson()}');
        }
        // You can send this to your API here
      },
    );
  }
}