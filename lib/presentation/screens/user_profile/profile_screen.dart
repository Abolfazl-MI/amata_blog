import 'dart:ffi';

import 'package:blog_app/Blocs/profile_cubit/profile_cubit.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:blog_app/gen/assets.gen.dart';
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
        child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: ((context, state) {
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
          if (state is ProfileLoadingState) {
            return Center(
              child: SpinKitDoubleBounce(
                color: SolidColors.red,
              ),
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
    TextEditingController controller = TextEditingController();
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
                  ontap: () {},
                  usageTip: 'You can\'t change your email address unless now'),
              Divider(
                color: SolidColors.lightGrey,
              ),
              // userName section
              _bordIteam(width,
                  usageStr: amataUser.userName!,
                  ontap: () => showEditDialog(
                      context: context,
                      title: 'Edit your User Name',
                      controller: controller,
                      hintText: 'Update your userName',
                      onTap: () {
                        Navigator.of(context).pop();

                        context
                            .read<ProfileCubit>()
                            .updateUserName(newUserName: controller.text);
                      }),
                  usageTip: 'Tap to change user name'),
              Divider(
                color: SolidColors.lightGrey,
              ),
              // bio section
              _bordIteam(width,
                  usageStr: amataUser.bio ?? 'sapmple bio you can have',
                  ontap: () => showEditDialog(
                      context: context,
                      title: 'Edit or add your bio',
                      controller: controller,
                      hintText: 'Update your bio',
                      onTap: () {
                        Navigator.of(context).pop();
                        context
                            .read<ProfileCubit>()
                            .updateAddBio(bio: controller.text);
                      }),
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

  showEditDialog(
      {required String title,
      required Function() onTap,
      required String hintText,
      required BuildContext context,
      required TextEditingController controller}) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: SolidColors.kindGray,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: controller,
                      style: TextStyle(color: SolidColors.red),
                      decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                    AppButton(
                        hintText: 'confirm',
                        buttonColor: SolidColors.red,
                        onTap: onTap,
                        width: MediaQuery.of(context).size.width)
                  ],
                ),
              ),
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
