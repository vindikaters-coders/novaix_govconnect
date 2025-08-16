import 'package:flutter/material.dart';

class SystemSettingsScreen extends StatefulWidget {
  const SystemSettingsScreen({super.key});
  
  @override
  SystemSettingsScreenState createState() => SystemSettingsScreenState();
}

class SystemSettingsScreenState extends State<SystemSettingsScreen> {
  final TextEditingController _escalationEmailController = TextEditingController();
  final TextEditingController _urgentTaskHoursController = TextEditingController();
  final TextEditingController _reminderHoursController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // Initialize with default values
    _escalationEmailController.text = 'admin@gov.lk';
    _urgentTaskHoursController.text = '48';
    _reminderHoursController.text = '24 hours';
  }
  
  @override
  void dispose() {
    _escalationEmailController.dispose();
    _urgentTaskHoursController.dispose();
    _reminderHoursController.dispose();
    super.dispose();
  }

  void _handleBack() {
    Navigator.pop(context);
  }

  void _handleSaveSettings() {
    // Handle save settings logic
    String escalationEmail = _escalationEmailController.text.trim();
    String urgentTaskHours = _urgentTaskHoursController.text.trim();
    String reminderHours = _reminderHoursController.text.trim();
    
    print('Saving settings:');
    print('Escalation Email: $escalationEmail');
    print('Urgent Task Hours: $urgentTaskHours');
    print('Reminder Hours: $reminderHours');
    
    // Add your save settings logic here
    // Show success message or navigate back
    _showSuccessMessage();
  }
  
  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Settings saved successfully'),
        backgroundColor: Color(0xFF34C759),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: CustomAppBar(
        title: 'System Settings',
        onBackPressed: _handleBack,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Global Settings Section
            SettingsSection(
              title: 'Global Settings',
              children: [
                SettingsGroup(
                  title: 'Emergency Handling',
                  children: [
                    SettingsTextField(
                      label: 'Escalation Contact (Email)',
                      controller: _escalationEmailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16),
                    SettingsTextField(
                      label: 'Urgent Task Threshold (hours)',
                      controller: _urgentTaskHoursController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Notification Rules Section
            SettingsSection(
              title: 'Notification Rules',
              children: [
                SettingsGroup(
                  children: [
                    SettingsTextField(
                      label: 'Appointment Reminder (hours before)',
                      controller: _reminderHoursController,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: 40),
            
            // Save Settings Button
            CustomButton(
              text: 'Save Settings',
              onPressed: _handleSaveSettings,
              isPrimary: false,
              backgroundColor: Color(0xFF34C759), // Green color
            ),
            
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// New Settings Section component
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1C1E),
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF000000).withValues(alpha: 0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }
}

// New Settings Group component
class SettingsGroup extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const SettingsGroup({
    super.key,
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF007AFF),
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: 12),
        ],
        ...children,
      ],
    );
  }
}

// New Settings Text Field component
class SettingsTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const SettingsTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1C1C1E),
            letterSpacing: -0.1,
          ),
        ),
        SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFFE5E5E7),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF1C1C1E),
              letterSpacing: -0.2,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}

// Reusable CustomAppBar component
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF007AFF),
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 24,
        ),
        onPressed: onBackPressed ?? () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: -0.4,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Reusable CustomButton component
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    Color textColor;
    
    if (backgroundColor != null) {
      buttonColor = backgroundColor!;
      textColor = Colors.white;
    } else {
      buttonColor = isPrimary ? Color(0xFF007AFF) : Color(0xFFF2F2F7);
      textColor = isPrimary ? Colors.white : Color(0xFF1C1C1E);
    }

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
          ),
        ),
      ),
    );
  }
}