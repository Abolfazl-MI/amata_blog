import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/repositories/user_repository.dart';
import 'package:blog_app/gen/fonts.gen.dart';
import 'package:blog_app/presentation/routes/app_route_names.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:blog_app/presentation/screens/global/widgets/button.dart';
import 'package:blog_app/presentation/screens/global/widgets/feilds.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompleteUserInformation extends StatefulWidget {
  @override
  State<CompleteUserInformation> createState() =>
      _CompleteUserInformationState();
}

class _CompleteUserInformationState extends State<CompleteUserInformation> {
  TextEditingController userNameController = TextEditingController();
  File? finalImage;
  ImagePicker _picker = ImagePicker();
  pickImage(ImageSource imagesource) async {
    XFile? pickedImage = await _picker.pickImage(source: imagesource);

    if (pickedImage != null) {
      setState(() {
        finalImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    // throw UnimplementedError();'
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.21,
              backgroundColor:
                  finalImage != null ? SolidColors.red : Colors.transparent,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            backgroundColor: SolidColors.gray,
                            title: Text(
                              'select where to get photo from',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: Container(
                              width: width,
                              height: 100,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await pickImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'Camera',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await pickImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.photo_outlined,
                                            color: Colors.white),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'Gallery',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                },
                child: CircleAvatar(
                    backgroundImage:
                        finalImage != null ? FileImage(finalImage!) : null,
                    backgroundColor: SolidColors.lightGrey,
                    radius: MediaQuery.of(context).size.width * 0.2,
                    child: finalImage == null
                        ? Center(
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              size: 40,
                            ),
                          )
                        : null),
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
              onTap: () {
                if (finalImage != null && userNameController.text != null) {
                  Map<String, User> passedData =
                      context.currentBeamLocation.data as Map<String, User>;
                  User currentUser = passedData['user']!;

                  UserRepository()
                      .updateCredentials(
                          user: currentUser,
                          userName: userNameController.text,
                          profileImage: finalImage!)
                      .then((value) {
                    if (value.operationResult == OperationResult.success) {
                      context.beamToReplacementNamed(AppRouteNames.homeScreen,);
                    }
                    if (value.operationResult == OperationResult.fail) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(value.data)));
                    }
                  });
                }
              },
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
