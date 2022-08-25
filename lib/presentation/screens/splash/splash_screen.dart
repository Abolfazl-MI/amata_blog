import 'package:beamer/beamer.dart';
import 'package:blog_app/gen/assets.gen.dart';
import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _goToHomePage();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 0.6,
            child: Image.asset(
              Assets.images.amataLogo.path,
              color: Colors.white,
            ),
          ),
          Text(
            'Amata Blog',
            style: TextStyle(color: Colors.white, fontSize: 49),
          )
        ],
      ),
    );
  }

  void _goToHomePage() async {
    await Future.delayed(Duration(seconds: 4));
    Beamer.of(context).beamToReplacementNamed(AppRouteNames.homeScreen);
  }
}
