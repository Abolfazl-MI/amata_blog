import 'package:blog_app/gen/assets.gen.dart';
import 'package:blog_app/gen/fonts.gen.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:blog_app/presentation/screens/global/widgets/feilds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  TextEditingController emailTextcontroller = TextEditingController();
  TextEditingController passwordTextcontroller = TextEditingController();
  TextEditingController userNameTextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _builBody(context),
    );
  }

  _builBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
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
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white, fontFamily: FontFamily.bebas),
            ),
            AppTextFormFeilds(
                hintText: 'Enter Your Email here',
                isFilled: true,
                fillColor: SolidColors.darkGrey,
                feildIcon: Icons.email_outlined,
                isPasswordFeild: false,
                controller: emailTextcontroller),
            AppTextFormFeilds(
                hintText: 'Enter Your UserName here',
                isFilled: true,
                fillColor: SolidColors.darkGrey,
                feildIcon: Icons.person_outline,
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
            Container(
              width: width,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: SolidColors.red),
              child: Center(
                child: Text(
                  'LogIn',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: SolidColors.darkGrey,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: SvgPicture.asset(Assets.icons.gmail),
                  ),
                ),
                Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: SolidColors.darkGrey,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Transform.scale(
                        scale: 0.7,
                        child: SvgPicture.asset(
                          Assets.icons.phone,
                        )),
                  ),
                )
              ],
            ),
            TextButton(
                onPressed: () {},
                child: RichText(
                    text: TextSpan(text: 'Have an account?', children: [
                  TextSpan(
                      text: 'Login', style: TextStyle(color: SolidColors.red))
                ]))),
          ],
        ),
      ),
    );
  }
}
