import 'package:flutter/material.dart';
import 'package:govconnect_app/widgets/custom_dashboard_card.dart';
import 'package:govconnect_app/widgets/custom_super_admin_dashboard.dart';
import 'package:govconnect_app/widgets/static_item.dart';
import 'package:govconnect_app/widgets/urgent_request_item.dart';

class SuperAdminDashboard extends StatefulWidget {
  const SuperAdminDashboard({super.key});

  @override
  SuperAdminDashboardState createState() => SuperAdminDashboardState();
}

class SuperAdminDashboardState extends State<SuperAdminDashboard> {
  void _handleSettings() {
    print('Settings pressed');
    // Navigate to settings screen
  }

  void _handleNotifications() {
    print('Notifications pressed');
    // Navigate to notifications screen
  }

  void _handleUrgentRequest(String requestType, String userName, String officer) {
    print('Urgent request pressed: $requestType for $userName');
    // Navigate to request details screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: DashboardAppBar(
        title: 'Super Admin',
        onSettingsPressed: _handleSettings,
        onNotificationsPressed: _handleNotifications,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // System Overview Card
            DashboardCard(
              title: 'System Overview',
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: StatisticItem(
                          title: 'Active Users',
                          value: '1,245',
                        ),
                      ),
                      Expanded(
                        child: StatisticItem(
                          title: 'Total Officers',
                          value: '152',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: StatisticItem(
                          title: 'Tasks in Progress',
                          value: '458',
                        ),
                      ),
                      Expanded(
                        child: StatisticItem(
                          title: 'Upcoming Bookings',
                          value: '98',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Urgent Requests Section
            Text(
              'Urgent Requests (3)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C1C1E),
                letterSpacing: -0.2,
              ),
            ),
            
            SizedBox(height: 12),
            
            // Urgent Request Items
            UrgentRequestItem(
              title: 'Urgent Passport Renewal',
              userName: 'Jane Doe',
              officer: 'Mr. A. Silva',
              onTap: () => _handleUrgentRequest('Passport Renewal', 'Jane Doe', 'Mr. A. Silva'),
            ),
            
            SizedBox(height: 8),
            
            UrgentRequestItem(
              title: 'Urgent Land Deed Transfer',
              userName: 'Roshan Rami',
              officer: 'Ms. R. Perera',
              onTap: () => _handleUrgentRequest('Land Deed Transfer', 'Roshan Rami', 'Ms. R. Perera'),
            ),
          ],
        ),
      ),
    );
  }
}