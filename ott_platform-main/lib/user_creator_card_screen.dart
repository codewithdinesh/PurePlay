import 'package:flutter/material.dart';
import 'package:ott_platform_app/common_widget/custom_button.dart';
import 'package:ott_platform_app/common_widget/video_player.dart';
import 'common/color_extension.dart';

class UserCreatorCardScreen extends StatelessWidget {
  const UserCreatorCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
          
              const SizedBox(
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary3,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                        child: const Text(
                          'User',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                        style: ElevatedButton.styleFrom(
                          primary: primary3,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                        child: const Text(
                          'Creator',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/adminloginview');
                },
                child: const Text('Login as admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
