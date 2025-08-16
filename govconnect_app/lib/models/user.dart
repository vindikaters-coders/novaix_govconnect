class User {
  final int id;
  final String email;
  final String firstname;
  final String role;

  User({
    required this.id,
    required this.email,
    required this.firstname,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstname: json['firstname'],
      role: json['role'],
    );
  }
}
