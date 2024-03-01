import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ott_platform/common/color_extension.dart';
import 'package:ott_platform/common_widget/round_button.dart';
import 'package:ott_platform/common_widget/round_text_field.dart';
import 'package:ott_platform/global.dart';
import 'package:ott_platform/google_auth.dart';
import 'package:ott_platform/model/UserData.dart';
import 'package:ott_platform/services/auth_service.dart';
import 'package:ott_platform/user_view/login/register_view.dart';
import 'package:ott_platform/user_view/main_tab/main_tab_view.dart';
import 'package:ott_platform/utils/Navigate.dart';
import 'package:ott_platform/utils/snackbar.dart';

import 'forgot_password_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  final AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    // Check user login status when the widget is initialized
    checkUserLoginStatus();
  }

  // Check Login Status
  Future<void> checkUserLoginStatus() async {
    AuthServices authServices = AuthServices();
    String? userToken = await authServices.getUserToken();
    UserData? user = await authServices.getUser();

    if (userToken != null) {
      print('User is logged in with token: $userToken');
      // User is logged in, navigate to the main screen or perform other actions

      String userType = user!.role;

      if (userType == "user") {
        //  TO-DO: Verify Token is valid or not with the backend
        Navigate.toPageWithReplacement(context, const MainTabView());
      }

      // If not user then logout
      else {
        await authServices.deleteUserToken();
        await authServices.deleteUser();
        showSnackBar(context, "Please login again.", isError: true);
      }
    }
  }

// For loading
  bool isLoggingIn = false;

  Future<void> loginUser() async {
    setState(() {
      isLoggingIn = true;
    });

    try {
      if (txtEmail.text.isEmpty) {
        showSnackBar(context, "Please enter your email.", isError: true);
        return;
      }

      if (txtPassword.text.isEmpty) {
        showSnackBar(context, "Please enter your password.", isError: true);

        return;
      }

      Map<String, String> credentials = {
        'email': txtEmail.text,
        'password': txtPassword.text,
      };

      http.Response res = await http.post(
        Uri.parse('$uri/auth/v1/signin'),
        headers: <String, String>{
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: credentials,
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        showSnackBar(context, "Login Successful");

        Map<String, dynamic> successResponse = jsonDecode(res!.body);
        String userToken = successResponse['token'];
        UserData user = UserData.fromJson(successResponse['data']);

        // Store Login Token in the Google AUth Secure Storage

        await AuthServices().saveUserToken(userToken);

        // Save other user details
        await AuthServices().saveUser(user);

        // Navigate to the main tab view after successful login
        Navigate.toPageWithReplacement(context, const MainTabView());
      } else if (res.statusCode == 401 ||
          res.statusCode == 404 ||
          res.statusCode == 500 ||
          res.statusCode == 409) {
        // Handle Errors
        // print("res:" + res.body.toString());

        Map<String, dynamic> errorResponse = jsonDecode(res!.body);
        String errorMessage = errorResponse['error'] ??
            errorResponse['message'] ??
            'Unknown error';
        showSnackBar(context, errorMessage, isError: true);
      } else {
        // Handle other status codes as needed
        showSnackBar(context, "Unexpected error occurred.", isError: true);
      }
    } catch (e) {
      print("try:" + e.toString());
      showSnackBar(context, e.toString(), isError: true);
    } finally {
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.bg,

      // Color Mode
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

      // Login Page
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            width: media.width,
            height: media.width,
            child: ClipRect(
              child: Transform.scale(
                  scale: 1.3,
                  child: Image.asset(
                    "assets/img/login_top.png",
                    width: media.width,
                    height: media.width,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Container(
            width: media.width,
            height: media.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                TColor.bg.withOpacity(0),
                TColor.bg.withOpacity(0),
                TColor.bg
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: media.width,
                    height: media.width * 0.5,
                    alignment: const Alignment(0, 0.5),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color:
                              TColor.tModeDark ? Colors.transparent : TColor.bg,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: TColor.tModeDark
                              ? null
                              : const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 4))
                                ]),
                      child: Text(
                        'PLAY',
                        style: TextStyle(color: TColor.primary2, fontSize: 60),
                      ),
                    ),
                  ),

                  // Email Input
                  RoundTextField(
                    title: "EMAIL",
                    hintText: "email here",
                    keyboardType: TextInputType.emailAddress,
                    controller: txtEmail,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Password Input
                  RoundTextField(
                    title: "PASSWORD",
                    hintText: "password here",
                    obscureText: true,
                    controller: txtPassword,
                    right: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordView()));
                      },

                      // Forgot Password
                      child: Text(
                        "FORGOT?",
                        style: TextStyle(
                            color: TColor.text,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Login Button
                  RoundButton(
                    title: "LOGIN",
                    onPressed: () {
                      loginUser();
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  // Social Logins
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: TColor.subtext,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Social Logins",
                          style: TextStyle(
                              color: TColor.text,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: TColor.subtext,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/img/fb_btn.png",
                          width: 45,
                          height: 45,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await AuthService().signInWithGoogle();
                          Navigator.pushNamed(context, '/maintabview');
                        },
                        icon: Image.asset(
                          "assets/img/google_btn.png",
                          width: 45,
                          height: 45,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Don’t have an account?",
                    style: TextStyle(
                        color: TColor.subtext,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterView()));
                    },
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                          color: TColor.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
