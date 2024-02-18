import 'dart:convert';

class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String role;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'role': role,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
