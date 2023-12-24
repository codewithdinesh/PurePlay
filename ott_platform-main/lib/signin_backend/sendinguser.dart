import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ott_platform_app/global.dart';
import 'package:ott_platform_app/signin_backend/error_handling.dart';
import 'package:ott_platform_app/signin_backend/snackbar.dart';
import 'package:ott_platform_app/signin_backend/userstruct.dart';

class AuthService1 {
  // User SignIn
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      print(Uri.parse('$uri/auth/v1/signin'));

      http.Response res = await http.post(Uri.parse('$uri/auth/v1/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print("Yay! Logged IN");
        },
        onError: (error) {
          // Display an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

// User SignUp
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String confirmpassword,
      required String username}) async {
    try {
      UserStruct user = UserStruct(
          id: '',
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          username: username,
          confirmpassword: confirmpassword);

      print(Uri.parse('$uri/auth/v1/signup'));
      http.Response res = await http.post(Uri.parse('$uri/auth/v1/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            print("Yay! Logged IN");
            // Display a success message if needed
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login successful!")),
            );
          },
          onError: (error) {
            // Display an error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString())),
            );
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
