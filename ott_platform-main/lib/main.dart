import 'package:flutter/material.dart';
import 'package:ott_platform_app/admin/admin_login_view.dart';
import 'package:ott_platform_app/admin/admin_screen.dart';
import 'package:ott_platform_app/admin/main_tab/admin_main_tab_view.dart';
import 'package:ott_platform_app/common_widget/checkout1.dart';
import 'package:ott_platform_app/content_approval_process/getcontent.dart';
import 'package:ott_platform_app/creator_view/login/creator_login_view.dart';
import 'package:ott_platform_app/creator_view/login/creator_register_view.dart';
import 'package:ott_platform_app/creator_view/main_tab/creator_main_tab_view.dart';
import 'package:ott_platform_app/splash_screen.dart';
import 'package:ott_platform_app/user_creator_card_screen.dart';
import 'package:ott_platform_app/user_view/login/login_view.dart';
import 'package:ott_platform_app/user_view/login/register_view.dart';
import 'package:ott_platform_app/user_view/main_tab/main_tab_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');

  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Gotham",
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/registerview': (context) => const RegisterView(),
        '/creatorregisterview': (context) => const CreatorRegisterView(),
        '/maintabview': (context) => const MainTabView(),
        '/loginview': (context) => const LoginView(),
        '/usercreatorcardscreen': (context) => const UserCreatorCardScreen(),
        '/creatormaintabview': (context) => const CreatorMainTabView(),
        '/adminscreen': (context) => const AdminScreen(),
        '/creatorloginview': (context) => const CreatorLoginView(),
        '/adminloginview': (context) => const AdminLoginView(),
        '/adminmaintabview': (context) => const AdminMainTabView(),
        '/checkout': (context) => const CheckoutOnePage(),
        '/videoListScreen': (context) =>
            VideoListScreen(context as List<String>),
      },
    );
  }
}
