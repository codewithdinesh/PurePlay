import 'dart:convert';

class UserStruct {
  final String id;
  final String name;
  final String email;
  final String password;
  final String confirmpassword;
  UserStruct(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.confirmpassword});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'confirmpassword': confirmpassword
    };
  }

  factory UserStruct.fromMap(Map<String, dynamic> map) {
    // ignore: unnecessary_null_comparison

    return UserStruct(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      confirmpassword: map['confirmpassword'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserStruct.fromJson(String source) =>
      UserStruct.fromMap(json.decode(source));
}
