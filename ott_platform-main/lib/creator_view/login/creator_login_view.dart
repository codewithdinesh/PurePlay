import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ott_platform_app/creator_view/login/creator_register_view.dart';
import 'package:ott_platform_app/creator_view/main_tab/creator_main_tab_view.dart';
import 'package:ott_platform_app/global.dart';
import 'package:ott_platform_app/google_auth.dart';
import 'package:ott_platform_app/model/UserData.dart';
import 'package:ott_platform_app/services/auth_service.dart';
import 'package:ott_platform_app/user_view/login/register_view.dart';
import 'package:ott_platform_app/user_view/main_tab/main_tab_view.dart';
import 'package:ott_platform_app/google_auth.dart';
import 'package:ott_platform_app/utils/Navigate.dart';
import 'package:ott_platform_app/utils/snackbar.dart';
import 'package:http/http.dart' as http;

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_text_field.dart';
import 'forgot_password_view.dart';

class CreatorLoginView extends StatefulWidget {
  const CreatorLoginView({super.key});

  @override
  State<CreatorLoginView> createState() => _CreatorLoginViewState();
}

class _CreatorLoginViewState extends State<CreatorLoginView> {
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

    if (userToken != null) {
      print('User is logged in with token: $userToken');
      // User is logged in, navigate to the main screen or perform other actions

      // TO-DO: Verify Token is valid or not with the backend
      Navigate.toPageWithReplacement(context, const CreatorMainTabView());
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

        UserData user = UserData.fromJson(successResponse['data']);
        String userToken = successResponse['token'];

        // Store Login Token in the Google AUth Secure Storage

        await AuthServices().saveUserToken(userToken);

        // Navigate to the main tab view after successful login
        // Navigate.toPageWithReplacement(context, const CreatorMainTabView());

        Navigator.pushNamed(context, '/creatormaintabview');


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

                  //Email
                  RoundTextField(
                    title: "EMAIL",
                    hintText: "email here",
                    keyboardType: TextInputType.emailAddress,
                    controller: txtEmail,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Password
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

                  // Creator Login Button
                  RoundButton(
                    title: "LOGIN",
                    onPressed: () {
                      loginUser();
                      // Navigator.pushNamed(context, '/creatormaintabview');
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
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

                      // Google Login
                      IconButton(
                        onPressed: () async {
                          await AuthService().signInWithGoogle();
                          Navigator.pushNamed(context, '/creatormaintabview');
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

                  // Register
                  Text(
                    "Don’t have an account?",
                    style: TextStyle(
                        color: TColor.subtext,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),

                  // Register Button
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/creatorregisterview');
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
