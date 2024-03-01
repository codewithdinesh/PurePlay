import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_text_field.dart';
import '../../global.dart';
import '../../google_auth.dart';
import '../../model/UserData.dart';
import '../../services/auth_service.dart';
import '../../utils/Navigate.dart';
import '../../utils/snackbar.dart';
import '../main_tab/main_tab_view.dart';
import 'forgot_password_view.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? image;

  bool isSigningUp = false; // Added a flag to track the signup state

  Future<void> signUpUser() async {
    setState(() {
      isSigningUp = true; // Set flag to true when signup begins
    });

    try {
      if (txtFirstName.text.isEmpty) {
        showSnackBar(context, "Please enter your first name.", isError: true);
        return;
      }

      if (txtLastName.text.isEmpty) {
        showSnackBar(context, "Please enter your last name.", isError: true);
        return;
      }

      if (txtEmail.text.isEmpty) {
        showSnackBar(context, "Please enter your email.", isError: true);
        return;
      }

      if (txtUsername.text.isEmpty) {
        showSnackBar(context, "Please enter your username.", isError: true);
        return;
      }

      if (txtPassword.text.isEmpty) {
        showSnackBar(context, "Please enter your password.", isError: true);
        return;
      }

      if (txtConfirmPassword.text.isEmpty) {
        showSnackBar(context, "Please confirm your password.", isError: true);
        return;
      }
      Map<String, String> user = {
        'firstName': txtFirstName.text,
        'lastName': txtLastName.text,
        'email': txtEmail.text,
        'username': txtUsername.text,
        'password': txtPassword.text,
        'confirmpassword': txtConfirmPassword.text,
        'usertype': "viewer"
      };

      http.Response res = await http.post(
        Uri.parse('$uri/auth/v1/signup'),
        headers: <String, String>{
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: user,
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        showSnackBar(context, "User Registered Successfully");

        Navigate.toPageWithReplacement(context, const LoginView());
      } else if (res.statusCode == 400 || res.statusCode == 409) {
        // Handle conflict error such as Bad Request and invalid input

        Map<String, dynamic> errorResponse = jsonDecode(res!.body);
        String errorMessage = errorResponse['error'] ??
            errorResponse['message'] ??
            'Unknown error';
        showSnackBar(context, errorMessage, isError: true);
      } else if (res.statusCode == 500) {
        // Handle internal server error
        showSnackBar(context, "Internal server error.", isError: true);
      } else {
        // Handle other status codes as needed
        showSnackBar(context, "Unexpected error occurred.", isError: true);
      }
    } catch (e) {
      print("try:" + e.toString());
      showSnackBar(context, e.toString(), isError: true);
    } finally {
      setState(() {
        isSigningUp = false; // Reset flag after signup completes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 100,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/img/back_btn.png",
                    width: 13,
                    height: 13,
                    color: TColor.subtext,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "BACK",
                    style: TextStyle(
                        color: TColor.subtext,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: TColor.bg,
        floatingActionButton: FloatingActionButton(
          backgroundColor: TColor.primary1,
          onPressed: () {
            TColor.tModeDark = !TColor.tModeDark;
            if (mounted) {
              setState(() {});
            }
          },
          child: Icon(
            TColor.tModeDark ? Icons.light_mode : Icons.dark_mode,
            color: TColor.text,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: media.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        image =
                            await picker.pickImage(source: ImageSource.gallery);

                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: TColor.card,
                            borderRadius:
                                BorderRadius.circular(media.width * 0.15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 4))
                            ]),
                        child: image != null
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(media.width * 0.15),
                                child: Image.file(
                                  File(image!.path),
                                  width: media.width * 0.18,
                                  height: media.width * 0.18,
                                  fit: BoxFit.cover,
                                ))
                            : ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(media.width * 0.15),
                                child: Image.asset(
                                  "assets/img/user_placeholder.png",
                                  width: media.width * 0.18,
                                  height: media.width * 0.18,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Add profile picture",
                      style: TextStyle(
                          color: TColor.text,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                // First Name
                RoundTextField(
                  title: "FIRST NAME",
                  hintText: "first name here",
                  controller: txtFirstName,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Last Name
                RoundTextField(
                  title: "LAST NAME",
                  hintText: "last name here",
                  controller: txtLastName,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Username
                RoundTextField(
                    title: "USERNAME",
                    hintText: "Username here",
                    controller: txtUsername),
                const SizedBox(
                  height: 20,
                ),

                // Email
                RoundTextField(
                  title: "EMAIL",
                  hintText: "email here",
                  keyboardType: TextInputType.emailAddress,
                  controller: txtEmail,
                ),
                const SizedBox(
                  height: 20,
                ),

                // password
                RoundTextField(
                  title: "PASSWORD",
                  hintText: "password here",
                  obscureText: true,
                  controller: txtPassword,
                ),
                const SizedBox(
                  height: 20,
                ),

                //Confirm Password
                RoundTextField(
                  title: "CONFIRM PASSWORD",
                  hintText: "confirm password here",
                  obscureText: true,
                  controller: txtConfirmPassword,
                ),
                const SizedBox(
                  height: 30,
                ),

                // Register Button
                RoundButton(
                  title: "REGISTER",
                  onPressed: () {
                    signUpUser();
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ));
  }
}
