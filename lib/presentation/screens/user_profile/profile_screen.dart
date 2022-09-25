import 'dart:ffi';

import 'package:blog_app/Blocs/profile_cubit/profile_cubit.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:blog_app/presentation/screens/global/colors/solid_colors.dart';
import 'package:blog_app/presentation/screens/global/widgets/button.dart';
import 'package:blog_app/presentation/screens/global/widgets/feilds.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        child: BlocConsumer<ProfileCubit,ProfileState>(listener: ((context, state) {
          if (state is ProfileErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(state.error),
                      ));
            });
          }
        }), builder: (context, state) {
          if (state is ProfileLoadedState) {
            return Stack(
              children: [
                // profile image section
                CachedNetworkImage(
                  placeholder: ((context, url) => Container(
                      width: width,
                      height: height / 3,
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: SolidColors.red,
                        ),
                      ))),
                  errorWidget: ((context, url, error) => Container(
                        width: width,
                        height: height / 3,
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 30,
                            color: SolidColors.red,
                          ),
                        ),
                      )),
                  imageUrl: state.amataUser.profileUrl!,
                  imageBuilder: ((context, imageProvider) => Container(
                        width: width,
                        height: height / 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill)),
                      )),
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
                _userInfosection(height, width, context,
                    amataUser: state.amataUser),
                Positioned(
                    left: width / 1.25,
                    top: height / 3.4,
                    child: FloatingActionButton(
                      backgroundColor: Colors.lightBlue,
                      onPressed: () {},
                      child: Icon(Icons.camera_alt_outlined),
                    )),
              ],
            );
          }
          if (state is ProfileErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(state.error),
                      ));
            });
          }
          return Container();
        }),
      ),
    );
  }

  _userInfosection(double height, double width, BuildContext context,
      {required AmataUser amataUser}) {
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
              // email section
              _bordIteam(width,
                  usageStr: amataUser.emailAddrress!,
                  ontap: () => showEditDialog(
                      context: context,
                      title: 'Edit your Email Adress',
                      hintText: 'Email Adress',
                      onConfrim: () {},
                      textEditingController: TextEditingController()),
                  usageTip: 'Tap to change emial address'),
              Divider(
                color: SolidColors.lightGrey,
              ),
              // userName section
              _bordIteam(width,
                  usageStr: amataUser.userName!,
                  ontap: () => showEditDialog(
                      context: context,
                      title: 'Edit your User Name',
                      hintText: 'UserName',
                      onConfrim: () {},
                      textEditingController: TextEditingController()),
                  usageTip: 'Tap to change user name'),
              Divider(
                color: SolidColors.lightGrey,
              ),
              // bio section
              _bordIteam(width,
                  usageStr: amataUser.bio ?? 'sapmple bio you can have',
                  ontap: () => showEditDialog(
                      context: context,
                      title: 'Edit your Bio',
                      hintText: 'bio',
                      onConfrim: () {},
                      textEditingController: TextEditingController()),
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

  showEditDialog({
    required BuildContext context,
    required String title,
    required String hintText,
    required Function() onConfrim,
    required TextEditingController textEditingController,
  }) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: SolidColors.kindGray,
              title: Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              content: AppTextFormFeilds(
                hintText: hintText,
                feildIcon: Icons.edit,
                isPasswordFeild: false,
                controller: textEditingController,
                fillColor: SolidColors.gray,
                isFilled: true,
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                ElevatedButton(
                  onPressed: onConfrim,
                  child: Text('Confirm'),
                  style: ElevatedButton.styleFrom(
                    primary: SolidColors.red,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    primary: SolidColors.red,
                  ),
                ),
              ],
            ));
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
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }
}
