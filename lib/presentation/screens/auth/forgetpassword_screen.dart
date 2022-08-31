import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/repositories/auth_repository.dart';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:blog_app/gen/assets.gen.dart';
import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:blog_app/presentation/screens/global/widgets/button.dart';
import 'package:blog_app/presentation/screens/global/widgets/feilds.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 0.5,
                child: Image.asset(
                  Assets.images.amataLogo.path,
                  color: Colors.white,
                ),
              ),
              Text(
                'Reset password link would send to your email',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: AppTextFormFeilds(
                  hintText: 'Email',
                  feildIcon: Icons.email_outlined,
                  isPasswordFeild: false,
                  controller: emailController,
                  isFilled: true,
                  fillColor: SolidColors.darkGrey,
                ),
              ),
              AppButton(
                  hintText: 'Reset password',
                  buttonColor: SolidColors.red,
                  onTap: () {
                    if (emailController.text.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            Center(
                                child: Card(
                              color: SolidColors.lightGrey,
                              child: TextButton(
                                  onPressed: () {
                                    AuthRepository().forGetPassword(
                                        email: emailController.text);
                                    context.beamToReplacementNamed(
                                        AppRouteNames.loginScree);
                                  },
                                  child: Text(
                                    'Ok',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ))
                          ],
                          content: Text(
                            'Reset Password link sent to your sandbox',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: SolidColors.darkGrey,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Feild couldn\'t be empty')));
                    }
                    //       .then((value) {
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) => AlertDialog(
                    //           title: Text('Alert'),
                    //           content: Text('Reset Password link sent to your email,cheack spam folder'),
                    //         ));
                    //   });
                    // }
                  },
                  width: MediaQuery.of(context).size.width * .5)
            ],
          ),
        ),
      ),
    );
  }
}
