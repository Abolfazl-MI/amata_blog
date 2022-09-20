import 'dart:ffi';

import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        // color: Colors.green,
        child: Stack(
          children: [
            // profile image section
            Container(
              width: width,
              height: height / 3,
              decoration: BoxDecoration(
                  // color: Colors.amber,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://files.virgool.io/upload/users/200359/posts/fqef3fpu0mxh/ofaavniattrj.png'))),
            ),
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: SolidColors.red,
                  size: 30,
                ),
              ),
            ),

// user info section
            _userInfosection(height, width),
            Positioned(
                left: width / 1.25,
                top: height / 3.4,
                child: FloatingActionButton(
                  backgroundColor: Colors.lightBlue,
                  onPressed: () {},
                  child: Icon(Icons.camera_alt_outlined),
                )),
          ],
        ),
      ),
    );
  }

  Positioned _userInfosection(double height, double width) {
    return Positioned(
      top: height / 3.1,
      child: Container(
        width: width,
        height: height / 3.38,
        color: SolidColors.darkGrey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              _bordIteam(width,
                  usageStr: 'Abolfazlmashhadi93@gmail.com',
                  ontap: () {},
                  usageTip: 'Tap to change emial address'),
              Divider(
                color: SolidColors.lightGrey,
              ),
              _bordIteam(width,
                  usageStr: 'Abolfazl23',
                  ontap: () {},
                  usageTip: 'Tap to change user name'),
              Divider(
                color: SolidColors.lightGrey,
              ),
              _bordIteam(width,
                  usageStr: 'sapmple bio you can have',
                  ontap: () {},
                  usageTip: 'Tap to change bio'),
              Divider(
                color: SolidColors.lightGrey,
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell _bordIteam(double width,
      {required String usageStr,
      required String usageTip,
      required Function() ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              usageStr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              usageTip,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
