import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ott_platform_app/admin/main_tab/admin_main_tab_view.dart';
import 'package:ott_platform_app/user_view/login/register_view.dart';
import 'package:ott_platform_app/utils/Navigate.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_text_field.dart';
import 'package:ott_platform_app/main.dart';

import '../global.dart';
import '../model/UserData.dart';
import '../services/auth_service.dart';
import '../utils/snackbar.dart';

class AdminLoginView extends StatefulWidget {
  const AdminLoginView({super.key});

  @override
  State<AdminLoginView> createState() => _AdminLoginViewState();
}

class _AdminLoginViewState extends State<AdminLoginView> {
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

    print('User Data: ${user?.toJson().toString()}');

    if (userToken != null) {
      print('User is logged in with token: $userToken');
      // User is logged in, navigate to the main screen or perform other actions

      String userType = user!.role;

      if (userType == 'admin') {
        // TO-DO: Verify Token is valid or not with the backend
        Navigate.toPageWithReplacement(context, const AdminMainTabView());
      }

      // If user is not a admin, then logout the user
      else {
        await authServices.deleteUserToken();
        await authServices.deleteUser();
        showSnackBar(context, "Please login as a creator.", isError: true);
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

        UserData user = UserData.fromJson(successResponse['data']);
        String userToken = successResponse['token'];

        // Store Login Token in the Google AUth Secure Storage

        await AuthServices().saveUserToken(userToken);

        // Store User Data in the Google AUth Secure Storage
        await AuthServices().saveUser(user);

        // Navigate to the main tab view after successful login
        // Navigate.toPageWithReplacement(context, const CreatorMainTabView());

        // Navigator.pushNamed(context, );
        Navigate.toPageWithReplacement(context, const AdminMainTabView());
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
                  RoundTextField(
                    title: "EMAIL",
                    hintText: "email here",
                    keyboardType: TextInputType.emailAddress,
                    controller: txtEmail,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundTextField(
                    title: "PASSWORD",
                    hintText: "password here",
                    obscureText: true,
                    controller: txtPassword,
                    /* right: TextButton(
                      onPressed: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPasswordView()));
                      },
                      child: Text(
                        "FORGOT?",
                        style: TextStyle(
                            color: TColor.text,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),*/
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundButton(
                    title: "LOGIN",
                    onPressed: () {
                      loginUser();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
