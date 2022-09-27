import 'package:blog_app/gen/assets.gen.dart';
import 'package:blog_app/gen/fonts.gen.dart';
import 'package:blog_app/Blocs/auth_bloc/auth_bloc.dart';
import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:blog_app/presentation/screens/global/widgets/button.dart';
import 'package:blog_app/presentation/screens/global/widgets/feilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  TextEditingController emailTextcontroller = TextEditingController();
  TextEditingController passwordTextcontroller = TextEditingController();
  // TextEditingController userNameTextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _builBody(context),
    );
  }

  _builBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<AuthBloc, AuthState>(
      listener: ((context, state) {
        if (state is AuthenticatedState) {
          print('authenticated');
          
          Navigator.of(context).pushReplacementNamed(
              AppRouteNames.completeInfoScreen,
              arguments: {'user': state.user});
        }

        if(state is LoadingState){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showDialog(context: context, builder: (context)=>Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
                color: SolidColors.darkGrey,
                padding: EdgeInsets.all(10),
                
                child: Center(
                  child: Lottie.asset(Assets.lotties.amtaLoading ),
                ),
              ),
            ));
          });
        }

        if (state is ErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.err)));
          });

        }
      }),
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
                  controller: emailTextcontroller),
              AppTextFormFeilds(
                isFilled: true,
                fillColor: SolidColors.darkGrey,
                hintText: 'Enter Your Password here',
                feildIcon: Icons.lock_open_rounded,
                isPasswordFeild: true,
                controller: passwordTextcontroller,
              ),
              AppButton(
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(SignUpWithEmailEvent(
                      emailAddress: emailTextcontroller.text,
                      password: passwordTextcontroller.text));
                },
                buttonColor: SolidColors.red,
                width: width,
                hintText: 'Signup',
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
                        .pushReplacementNamed(AppRouteNames.loginScreen);
                  },
                  child: RichText(
                      text: TextSpan(text: 'Have an account?', children: [
                    TextSpan(
                        text: 'Login', style: TextStyle(color: SolidColors.red))
                  ]))),
            ],
          ),
        ),
      ),
    );
  }
}
