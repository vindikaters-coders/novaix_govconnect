import 'package:flutter/material.dart';

class ManageOfficersScreen extends StatefulWidget {
  const ManageOfficersScreen({super.key});

  @override
  ManageOfficersScreenState createState() => ManageOfficersScreenState();
}

class ManageOfficersScreenState extends State<ManageOfficersScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Officer> officers = [
    Officer(
      name: 'Mr. R. Gamage',
      office: 'Grama Niladari Office, Panadura',
      avatar: 'R',
    ),
    Officer(
      name: 'Ms. A. Silva',
      office: 'Registrar General\'s Office, Colombo',
      avatar: 'A',
    ),
  ];
  
  List<Officer> filteredOfficers = [];
  
  @override
  void initState() {
    super.initState();
    filteredOfficers = officers;
    _searchController.addListener(_onSearchChanged);
  }
  
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
  
  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredOfficers = officers.where((officer) {
        return officer.name.toLowerCase().contains(query) ||
               officer.office.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _handleBack() {
    Navigator.pop(context);
  }

  void _handleAddOfficer() {
    print('Add Officer pressed');
    // Navigate to add officer screen
  }

  void _handleEditOfficer(Officer officer) {
    print('Edit officer: ${officer.name}');
    // Navigate to edit officer screen
  }

  void _handleDeleteOfficer(Officer officer) {
    print('Delete officer: ${officer.name}');
    // Show confirmation dialog and delete officer
    _showDeleteConfirmation(officer);
  }
  
  void _showDeleteConfirmation(Officer officer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Officer'),
          content: Text('Are you sure you want to delete ${officer.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  officers.removeWhere((o) => o.name == officer.name);
                  _onSearchChanged(); // Refresh filtered list
                });
                Navigator.pop(context);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: ManageAppBar(
        title: 'Manage Officers',
        onBackPressed: _handleBack,
        onAddPressed: _handleAddOfficer,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
                hintText: 'Search an officer...',
            ),
          ),
          
          // Officers List
          Expanded(
            child: filteredOfficers.isEmpty
                ? EmptyState(
                    message: _searchController.text.isEmpty 
                        ? 'No officers found' 
                        : 'No officers match your search',
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredOfficers.length,
                    itemBuilder: (context, index) {
                      final officer = filteredOfficers[index];
                      return OfficerListItem(
                        officer: officer,
                        onEdit: () => _handleEditOfficer(officer),
                        onDelete: () => _handleDeleteOfficer(officer),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Officer data model
class Officer {
  final String name;
  final String office;
  final String avatar;

  Officer({
    required this.name,
    required this.office,
    required this.avatar,
  });
}

// New Manage App Bar with add button
class ManageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onAddPressed;

  const ManageAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.onAddPressed,
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
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 24,
          ),
          onPressed: onAddPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


// New Officer List Item component
class OfficerListItem extends StatelessWidget {
  final Officer officer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const OfficerListItem({
    super.key,
    required this.officer,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFE5E5E7),
            child: Text(
              officer.avatar,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8E8E93),
              ),
            ),
          ),
          
          SizedBox(width: 12),
          
          // Officer Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  officer.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1C1C1E),
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  officer.office,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8E8E93),
                    letterSpacing: -0.1,
                  ),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onEdit,
                icon: Icon(
                  Icons.edit_outlined,
                  color: Color(0xFF007AFF),
                  size: 20,
                ),
                constraints: BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
              SizedBox(width: 4),
              IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_outline,
                  color: Color(0xFFFF3B30),
                  size: 20,
                ),
                constraints: BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// New Empty State component
class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search,
            size: 64,
            color: Color(0xFF8E8E93),
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8E8E93),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}