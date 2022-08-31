import 'dart:io';

import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection(DatabseConstants.usersCollection);
  final _userStorageRef = FirebaseStorage.instance;
  Future<RawData> updateCredentials(
      {required User user,
      required String userName,
      required File profileImage}) async {
    try {
      String fileName = profileImage.path.split('/').last;
      Reference profileBucket = _userStorageRef
          .ref()
          .child('profiles')
          .child(userName)
          .child(fileName);
      TaskSnapshot uploadTask = await profileBucket.putFile(profileImage);
      //  TaskSnapshot taskSnapshot= await _userStorageRef.ref().child(path).putFile(profileImage);
      String? profileLink;
      if (uploadTask.state == TaskState.success) {
        profileLink = await profileBucket.getDownloadURL();
      }

      print(profileLink);
      AmataUser amtaUser = AmataUser(
          emailAddrress: user.email,
          userName: userName,
          profileUrl: profileLink,
          savedArticles: []);
      await _userRef.doc(user.uid).set(amtaUser.toJson());

      return RawData(operationResult: OperationResult.success, data: true);
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }
}
 /* // incomplited function , sould complite codes
  Future<RawData> updateSinginCreadentials(
      {required File profileImage,
      required String userName,
      required String userEmailAdress,
      required String userPassword}) async {
    try {
      log('**********updating use info wti {username:$userName, imagepath${profileImage.path}}**********',
          name: 'Auth_Repository');
      String userProfileUrl = '';
      //TODO: file uploade to colud storage then implent the uploadProccess
      AmataUser user = AmataUser(
          emailAddrress: userEmailAdress,
          password: userPassword,
          profileUrl: userProfileUrl,
          savedArticles: [],
          userName: userName);
      DocumentReference resualt = await _userRef.add(user.toJson());

      return RawData(opereationResualt: OpereationResualt.succes, data: true);
    } catch (e) {
      return RawData(
          opereationResualt: OpereationResualt.fail, data: e.toString());
    }
  } */