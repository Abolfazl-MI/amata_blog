import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _userRef;

  final FirebaseStorage _userStorageRef;

  UserRepository(
      {FirebaseAuth? firebaseAuth,
      CollectionReference? userRef,
      FirebaseStorage? userStorageRef})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _userRef = userRef ??
            FirebaseFirestore.instance
                .collection(DatabaseConstants.usersCollection),
        _userStorageRef = userStorageRef ?? FirebaseStorage.instance;

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

  Future<RawData> saveArticleToReadingList(
      {required User user, required Article article}) async {
    try {
      log('****************saving article for ${user.email} user****************',
          name: 'user_repository');
      var document = await _userRef.doc(user.uid).get();
      if (document.exists) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        AmataUser amataUser = AmataUser.fromJson(data);
        amataUser.savedArticles?.add(article);
        await _userRef.doc(user.uid).update(amataUser.toJson());
        return RawData(
            operationResult: OperationResult.success,
            data: amataUser.savedArticles);
      } else {
        return RawData(
            operationResult: OperationResult.fail, data: 'sth went wrong');
      }
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  Future<RawData> deleteArticleReadingList(
      {required User user, required Article article}) async {
    try {
      log('*******delteing article from reading list******');
      var documnet = await _userRef.doc(user.uid).get();
      if (documnet.exists) {
        Map<String, dynamic> data = documnet.data() as Map<String, dynamic>;
        AmataUser amataUser = AmataUser.fromJson(data);
        amataUser.savedArticles?.remove(article);
        await _userRef.doc(user.uid).update(amataUser.toJson());
        return RawData(
            operationResult: OperationResult.success,
            data: amataUser.savedArticles);
      } else {
        return RawData(
            operationResult: OperationResult.fail, data: 'sth went wrong');
      }
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  Future<RawData> getProfileInfo() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        return RawData(operationResult: OperationResult.success, data: user);
      } else {
        return RawData(
            operationResult: OperationResult.fail, data: 'cant get user');
      }
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }
}
