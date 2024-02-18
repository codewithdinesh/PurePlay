import 'package:flutter/material.dart';
import 'package:ott_platform_app/user_view/login/register_view.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_text_field.dart';
import 'package:ott_platform_app/main.dart';

class AdminLoginView extends StatefulWidget {
  const AdminLoginView({super.key});

  @override
  State<AdminLoginView> createState() => _AdminLoginViewState();
}

class _AdminLoginViewState extends State<AdminLoginView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

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
                      Navigator.pushNamed(context, '/VideoListScreen');
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
