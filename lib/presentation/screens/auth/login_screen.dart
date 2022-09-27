import 'package:blog_app/gen/assets.gen.dart';
import 'package:blog_app/gen/fonts.gen.dart';
import 'package:blog_app/Blocs/auth_bloc/auth_bloc.dart';

import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:blog_app/presentation/screens/global/widgets/button.dart';
import 'package:blog_app/presentation/screens/global/widgets/feilds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _builtBody(context),
    );
  }

  _builtBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<AuthBloc, AuthState>(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform.scale(
                  scale: 0.4,
                  child: Image.asset(
                    Assets.images.amataLogo.path,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Amata Blog',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Colors.white, fontFamily: FontFamily.bebas),
                ),
                AppTextFormFeilds(
                    hintText: 'Enter Your Email here',
                    isFilled: true,
                    fillColor: SolidColors.darkGrey,
                    feildIcon: Icons.email_outlined,
                    isPasswordFeild: false,
                    controller: emailController),
                AppTextFormFeilds(
                  isFilled: true,
                  fillColor: SolidColors.darkGrey,
                  hintText: 'Enter Your Password here',
                  feildIcon: Icons.lock_open_rounded,
                  isPasswordFeild: true,
                  controller: passwordController,
                ),
                AppButton(
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(LoginWithEmailEvent(
                        emailAddress: emailController.text,
                        password: passwordController.text));
                  },
                  buttonColor: SolidColors.red,
                  hintText: 'Login',
                  width: width,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Container(
                //       width: 70,
                //       height: 70,
                //       padding: EdgeInsets.all(12),
                //       decoration: BoxDecoration(
                //           color: SolidColors.darkGrey,
                //           borderRadius: BorderRadius.circular(12)),
                //       child: Center(
                //         child: SvgPicture.asset(Assets.icons.gmail),
                //       ),
                //     ),
                //     Container(
                //       width: 70,
                //       height: 70,
                //       padding: EdgeInsets.all(12),
                //       decoration: BoxDecoration(
                //           color: SolidColors.darkGrey,
                //           borderRadius: BorderRadius.circular(12)),
                //       child: Center(
                //         child: Transform.scale(
                //             scale: 0.7,
                //             child: SvgPicture.asset(
                //               Assets.icons.phone,
                //             )),
                //       ),
                //     )
                //   ],
                // ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRouteNames.signUpScreen);
                    },
                    child: RichText(
                        text: TextSpan(text: 'Don\'t have account?', children: [
                      TextSpan(
                          text: 'SignUp',
                          style: TextStyle(color: SolidColors.red))
                    ]))),
                TextButton(
                    onPressed: () {
                      //TODO: navigate to forgot password page

                      Navigator.of(context).pushReplacementNamed(
                          AppRouteNames.forgetPassScreen,
                          arguments: emailController.text);
                    },
                    child: RichText(
                        text: TextSpan(text: 'Forgot password?', children: [
                      TextSpan(
                          text: 'reset Password',
                          style: TextStyle(color: SolidColors.red))
                    ]))),
              ],
            ),
          ),
        ),
        listener: (context, state) {
          if (state is LoadingState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: SpinKitDoubleBounce(
                          color: SolidColors.red,
                        ),
                      ));
            });
          }
          if(state is LoadingState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showDialog(context: context, builder: (context)=>Dialog(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/4,
                  color: SolidColors.darkGrey,

                  
                  child: Center(
                    child: Lottie.asset(Assets.lotties.amtaLoading ),
                  ),
                ),
              ));
            });
          }
          if (state is AuthenticatedState) {
            print('authenticated');
          
            Navigator.of(context).pushReplacementNamed(AppRouteNames.homeScreen,
                arguments: {'user': state.user});
          }
          if (state is ErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.err)));
            });
          }
        });
  }
}
/* return  */
