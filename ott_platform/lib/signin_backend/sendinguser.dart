import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import '../signin_backend/error_handling.dart';
import '../utils/snackbar.dart';
import '../signin_backend/userstruct.dart';

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

      print(user.toJson().toString());

      http.Response res = await http.post(
        Uri.parse('$uri/auth/v1/signup'),
        headers: <String, String>{
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: user.toFormUrlEncoded(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print("Yay! Signed up");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Signup successful!")),
          );
        },
        onError: (error) {
          print(error.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      print("try" + e.toString());

      showSnackBar(context, e.toString());
    }
  }
}
