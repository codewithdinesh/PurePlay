import 'dart:convert';

class UserStruct {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String username;
  final String confirmpassword;

  UserStruct(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.username,
      required this.confirmpassword});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'password': password,
      'confirmpassword': confirmpassword,
    };
  }

  factory UserStruct.fromMap(Map<String, dynamic> map) {
    // ignore: unnecessary_null_comparison

    return UserStruct(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
      confirmpassword: map['confirmpassword'],
      username: map['username']
    );
  }

  String toJson() => json.encode(toMap());

  factory UserStruct.fromJson(String source) =>
      UserStruct.fromMap(json.decode(source));
}
