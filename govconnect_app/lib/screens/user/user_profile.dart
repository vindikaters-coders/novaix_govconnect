import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final UserProfile userProfile = UserProfile(
    firstName: 'Sanath',
    lastName: 'Nandasiri',
    nic: '901234567V',
    dateOfBirth: '05/15/1990',
    gender: 'Male',
    phoneNumber: '+94771234567',
    email: 'john.p@example.com',
    city: 'Colombo',
    town: 'Dehiwala',
    province: 'Western',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        title: const Text(
          'My Profile',
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Profile Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'SN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Profile Form Fields
                  _buildFormField('First Name', userProfile.firstName),
                  const SizedBox(height: 16),

                  _buildFormField('Last Name', userProfile.lastName),
                  const SizedBox(height: 16),

                  _buildFormField('NIC', userProfile.nic),
                  const SizedBox(height: 16),

                  _buildFormField('Date of Birth', userProfile.dateOfBirth),
                  const SizedBox(height: 16),

                  _buildFormField('Gender', userProfile.gender),
                  const SizedBox(height: 16),

                  _buildFormField('Phone Number', userProfile.phoneNumber),
                  const SizedBox(height: 16),

                  _buildFormField('Email', userProfile.email),
                  const SizedBox(height: 16),

                  _buildFormField('City', userProfile.city),
                  const SizedBox(height: 16),

                  _buildFormField('Town', userProfile.town),
                  const SizedBox(height: 16),

                  _buildFormField('Province', userProfile.province),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Edit Profile Button
          _buildEditProfileButton(),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditProfileButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _editProfile,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2196F3),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(userProfile: userProfile),
      ),
    );
  }
}

// Edit Profile Page
class EditProfilePage extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfilePage({
    super.key,
    required this.userProfile,
  });

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _nicController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _genderController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _cityController;
  late TextEditingController _townController;
  late TextEditingController _provinceController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.userProfile.firstName);
    _lastNameController = TextEditingController(text: widget.userProfile.lastName);
    _nicController = TextEditingController(text: widget.userProfile.nic);
    _dateOfBirthController = TextEditingController(text: widget.userProfile.dateOfBirth);
    _genderController = TextEditingController(text: widget.userProfile.gender);
    _phoneController = TextEditingController(text: widget.userProfile.phoneNumber);
    _emailController = TextEditingController(text: widget.userProfile.email);
    _cityController = TextEditingController(text: widget.userProfile.city);
    _townController = TextEditingController(text: widget.userProfile.town);
    _provinceController = TextEditingController(text: widget.userProfile.province);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nicController.dispose();
    _dateOfBirthController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _townController.dispose();
    _provinceController.dispose();
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
          'Edit Profile',
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Profile Avatar with edit option
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2196F3),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'SN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Editable Form Fields
                  _buildEditableField('First Name', _firstNameController),
                  const SizedBox(height: 16),

                  _buildEditableField('Last Name', _lastNameController),
                  const SizedBox(height: 16),

                  _buildEditableField('NIC', _nicController, readOnly: true),
                  const SizedBox(height: 16),

                  _buildEditableField('Date of Birth', _dateOfBirthController,
                      onTap: () => _selectDate(context)),
                  const SizedBox(height: 16),

                  _buildGenderDropdown(),
                  const SizedBox(height: 16),

                  _buildEditableField('Phone Number', _phoneController),
                  const SizedBox(height: 16),

                  _buildEditableField('Email', _emailController),
                  const SizedBox(height: 16),

                  _buildEditableField('City', _cityController),
                  const SizedBox(height: 16),

                  _buildEditableField('Town', _townController),
                  const SizedBox(height: 16),

                  _buildProvinceDropdown(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Save Changes Button
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildEditableField(
      String label,
      TextEditingController controller, {
        bool readOnly = false,
        VoidCallback? onTap,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: readOnly ? Colors.grey[100] : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF2196F3)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _genderController.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF2196F3)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          items: ['Male', 'Female', 'Other'].map((gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              _genderController.text = value;
            }
          },
        ),
      ],
    );
  }

  Widget _buildProvinceDropdown() {
    final provinces = [
      'Western', 'Central', 'Southern', 'Northern', 'Eastern',
      'North Western', 'North Central', 'Uva', 'Sabaragamuwa'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Province',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _provinceController.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF2196F3)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          items: provinces.map((province) {
            return DropdownMenuItem<String>(
              value: province,
              child: Text(province),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              _provinceController.text = value;
            }
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _saveProfile,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Save Changes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 5, 15),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
        '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  void _saveProfile() {
    // Here you would save the profile data
    // For now, just show a success message and go back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Color(0xFF4CAF50),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pop();
  }
}

// User Profile Model
class UserProfile {
  final String firstName;
  final String lastName;
  final String nic;
  final String dateOfBirth;
  final String gender;
  final String phoneNumber;
  final String email;
  final String city;
  final String town;
  final String province;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.nic,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.city,
    required this.town,
    required this.province,
  });

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'nic': nic,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'city': city,
      'town': town,
      'province': province,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      nic: json['nic'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      city: json['city'] ?? '',
      town: json['town'] ?? '',
      province: json['province'] ?? '',
    );
  }
}