import 'package:flutter/material.dart';
import '../../common/color_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //checking for app update
      Future.delayed(Duration(seconds: 2)).then((value) {
        // context.pushNamed(RoutesName.homeScreen);
        Navigator.pushNamed(context, '/usercreatorcardscreen');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bgDark,
      body: Center(
        child: Text(
          'PLAY',
          style: TextStyle(color: TColor.primary2, fontSize: 60),
        ),
      ),
    );
  }
}
