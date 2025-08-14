import 'package:flutter/material.dart';

import 'book_appointment.dart';

class BookOfficerPage extends StatefulWidget {
  const BookOfficerPage({super.key});

  @override
  BookOfficerPageState createState() => BookOfficerPageState();
}

class BookOfficerPageState extends State<BookOfficerPage> {
  String? selectedOffice;
  String? selectedService;
  Officer? selectedOfficer;

  final List<String> offices = [
    'Registrar General\'s Office',
    'Police Station - Fort Branch',
    'Department of Motor Traffic',
    'Department of Pensions',
    'Ministry of Health - Public Clinic',
  ];

  final List<String> services = [
    'Birth Certificate',
    'Marriage Certificate',
    'Death Certificate',
    'Police Report',
    'Vehicle Registration',
    'Pension Inquiry',
    'Medical Certificate',
  ];

  final List<Officer> officers = [
    Officer(
      name: 'Mr. S. Perera',
      role: 'Document Verification Officer',
      deskNo: '2B',
      extension: '1234',
      isAvailable: true,
    ),
    Officer(
      name: 'Mrs. A. Silva',
      role: 'Legal Advisor',
      deskNo: '3A',
      extension: '5678',
      isAvailable: false,
    ),
    Officer(
      name: 'Dr. K. Fernando',
      role: 'Medical Officer',
      deskNo: '1C',
      extension: '9012',
      isAvailable: true,
    ),
    Officer(
      name: 'Mr. R. Bandara',
      role: 'Registration Officer',
      deskNo: '4D',
      extension: '3456',
      isAvailable: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        title: const Text(
          'Book an Officer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Office
            _buildSectionTitle('Select Office'),
            const SizedBox(height: 12),
            _buildOfficeDropdown(),
            const SizedBox(height: 24),

            // Select Service
            _buildSectionTitle('Select Service'),
            const SizedBox(height: 12),
            _buildServiceDropdown(),
            const SizedBox(height: 24),

            // Officer List
            if (selectedOffice != null && selectedService != null) ...[
              _buildOfficersList(),
            ],
          ],
        ),
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

  Widget _buildOfficeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedOffice,
          hint: const Text(
            'Select an office',
            style: TextStyle(color: Colors.grey),
          ),
          isExpanded: true,
          items: offices.map((office) {
            return DropdownMenuItem<String>(
              value: office,
              child: Text(
                office,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedOffice = value;
              selectedOfficer = null; // Reset officer selection
            });
          },
        ),
      ),
    );
  }

  Widget _buildServiceDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedService,
          hint: const Text(
            'Select a service',
            style: TextStyle(color: Colors.grey),
          ),
          isExpanded: true,
          items: services.map((service) {
            return DropdownMenuItem<String>(
              value: service,
              child: Text(
                service,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedService = value;
              selectedOfficer = null; // Reset officer selection
            });
          },
        ),
      ),
    );
  }

  Widget _buildOfficersList() {
    // Sort officers: available ones first
    final sortedOfficers = List<Officer>.from(officers)
      ..sort((a, b) => (b.isAvailable ? 1 : 0).compareTo(a.isAvailable ? 1 : 0));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Officers',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...sortedOfficers.map((officer) => _buildOfficerCard(officer)),
      ],
    );
  }

  Widget _buildOfficerCard(Officer officer) {
    final isSelected = selectedOfficer?.name == officer.name;
    final bool isAvailable = officer.isAvailable;

    // Define colors for the card based on availability
    final cardColor = isAvailable ? Colors.white : Colors.grey[200]!;
    final borderColor = isSelected && isAvailable ? const Color(0xFF2196F3) : Colors.grey[300]!;
    final textColor = isAvailable ? Colors.black87 : Colors.grey[500]!;
    final subtitleColor = isAvailable ? Colors.grey[600]! : Colors.grey[400]!;
    final detailColor = isAvailable ? Colors.grey[500]! : Colors.grey[400]!;

    return GestureDetector(
      onTap: isAvailable ? () => _selectOfficer(officer) : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: isSelected && isAvailable ? 2 : 1,
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
        child: Row(
          children: [
            // Officer Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isAvailable ? Colors.grey[300] : Colors.grey[300]!,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  officer.name.split(' ').map((n) => n[0]).take(2).join(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isAvailable ? Colors.black54 : Colors.grey[500]!,
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Role: ${officer.role}',
                    style: TextStyle(
                      fontSize: 14,
                      color: subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Desk No: ${officer.deskNo} | Ext: ${officer.extension}',
                    style: TextStyle(
                      fontSize: 12,
                      color: detailColor,
                    ),
                  ),
                ],
              ),
            ),

            // Status and Action
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isAvailable
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFF44336),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isAvailable ? 'Available' : 'Unavailable',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (isAvailable)
                  ElevatedButton(
                    onPressed: () => _selectOfficer(officer),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFF2196F3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      isSelected ? 'Selected' : 'Book',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _selectOfficer(Officer officer) {
    setState(() {
      selectedOfficer = officer;
    });

    // Navigate to appointment booking page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookAppointmentPage(
          office: selectedOffice!,
          service: selectedService!,
          officer: officer,
        ),
      ),
    );
  }
}

// Officer Model
class Officer {
  final String name;
  final String role;
  final String deskNo;
  final String extension;
  final bool isAvailable;

  Officer({
    required this.name,
    required this.role,
    required this.deskNo,
    required this.extension,
    required this.isAvailable,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'deskNo': deskNo,
      'extension': extension,
      'isAvailable': isAvailable,
    };
  }
}