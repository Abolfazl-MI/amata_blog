import 'package:beamer/beamer.dart';
import 'package:blog_app/Blocs/splash_cubit/splash_cubit.dart';
import 'package:blog_app/gen/assets.gen.dart';
import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) async {
          if (state is UnRegisteredState) {
            await Future.delayed(Duration(seconds: 4));
            Beamer.of(context)
                .beamToReplacementNamed(AppRouteNames.signUpScreen);
          }
          if(state is RegisteredState){
            await Future.delayed(Duration(seconds: 4));
            Beamer.of(context)
                .beamToReplacementNamed(AppRouteNames.homeScreen);
          }
          
        },
        child: Column(
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
      ),
    );
  }
}
