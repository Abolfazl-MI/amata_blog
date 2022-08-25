import 'package:blog_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Transform.scale(
            scale: 0.6,
            child: Image.asset(
              Assets.images.amataLogo.path,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          'Amata Blog',
          style: TextStyle(color: Colors.white, fontSize: 45),
        )
      ],
    ));
  }
}
