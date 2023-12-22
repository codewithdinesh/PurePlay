import 'package:flutter/material.dart';
import 'package:ott_platform_app/common_widget/custom_button.dart';

import 'common/color_extension.dart';

class UserCreatorCardScreen extends StatefulWidget {
  const UserCreatorCardScreen({super.key});

  @override
  State<UserCreatorCardScreen> createState() => _UserCreatorCardScreenState();
}

class _UserCreatorCardScreenState extends State<UserCreatorCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 240,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 155,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/loginview');
                        },
                        child: Text(
                          'user',
                          style: const TextStyle(
                              fontSize: 17, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: primary3,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 155,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/creatorloginview');
                        },
                        child: Text(
                          'Creator',
                          style: const TextStyle(
                              fontSize: 17, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: primary3,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/adminloginview');
                },
                child: Text('Login as admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
