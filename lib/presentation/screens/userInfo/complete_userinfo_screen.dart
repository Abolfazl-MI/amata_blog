import 'package:blog_app/gen/fonts.gen.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:blog_app/presentation/screens/global/widgets/button.dart';
import 'package:blog_app/presentation/screens/global/widgets/feilds.dart';
import 'package:flutter/material.dart';

class CompleteUserInformation extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: CircleAvatar(
                backgroundColor: SolidColors.lightGrey,
                radius: MediaQuery.of(context).size.width * 0.2,
                child: Center(
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    size: 40,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: AppTextFormFeilds(
                hintText: 'User Name',
                feildIcon: Icons.person_outline,
                isPasswordFeild: false,
                controller: userNameController,
                isFilled: true,
                fillColor: SolidColors.darkGrey,
              ),
            ),
            AppButton(
              hintText: 'Complete Singing ',
              buttonColor: SolidColors.red,
              onTap: () {},
              width: width * 0.5,
              hintTextStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontFamily: FontFamily.roboto,
                  fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
