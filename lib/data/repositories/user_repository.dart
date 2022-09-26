import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/articles/article_modle.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserRepositories {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _userRef;

  final FirebaseStorage _userStorageRef;

  UserRepositories(
      {FirebaseAuth? firebaseAuth,
      CollectionReference? userRef,
      FirebaseStorage? userStorageRef})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _userRef = userRef ??
            FirebaseFirestore.instance
                .collection(DatabaseConstants.usersCollection),
        _userStorageRef = userStorageRef ?? FirebaseStorage.instance;

  Future<RawData> updateCredentials({
    required User user,
    required String userName,
    required File profileImage,
  }) async {
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
          uid: user.uid,
          savedArticles: []);
      print(amtaUser.uid);
      await _userRef.doc(user.uid).set(amtaUser.toJson());

      return RawData(operationResult: OperationResult.success, data: true);
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  Future<RawData> saveArticleToReadingList({required Article article}) async {
    try {
      log('saving ${article.title} to user list');
      var curentUserRawData =
          await _userRef.doc(_firebaseAuth.currentUser!.uid).get();
      AmataUser user =
          AmataUser.fromJson(curentUserRawData.data() as Map<String, dynamic>);

      if (user.savedArticles!.isEmpty) {
        user.savedArticles!.add(article);
        await _userRef.doc(user.uid).update({
          'savedArticles': user.savedArticles!.map((e) => e.toJson()).toList()
        });
        return RawData(
            operationResult: OperationResult.success,
            data: 'article saved succesfullu');
      }
      if (user.savedArticles!.isNotEmpty) {
        bool contains = _contains(user.savedArticles!, article);
        print(contains);
        if (contains) {
          return RawData(
              operationResult: OperationResult.fail,
              data: 'article had saved before');
        } else {
          user.savedArticles!.add(article);
          await _userRef.doc(user.uid).update({
            'savedArticles': user.savedArticles!.map((e) => e.toJson()).toList()
          });
          return RawData(
              operationResult: OperationResult.success,
              data: 'article saved succesfull');
        }
      }
      return RawData(
          operationResult: OperationResult.fail, data: 'something went wrong');
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  Future<RawData> deleteArticleReadingList({required Article article}) async {
    try {
      log('*******delteing article from reading list******');
      User? user = await _firebaseAuth.currentUser;
      var documnet = await _userRef.doc(user!.uid).get();
      if (documnet.exists) {
        Map<String, dynamic> data = documnet.data() as Map<String, dynamic>;
        AmataUser amataUser = AmataUser.fromJson(data);
        if (amataUser.savedArticles!.isNotEmpty) {
          print(
              'before remove object from list lengh is ${amataUser.savedArticles!.length}');
          await amataUser.savedArticles!.remove(article);
          print(amataUser.savedArticles!.length);
          await _userRef.doc(user.uid).update({
            'savedArticles':
                amataUser.savedArticles!.map((e) => e.toJson()).toList()
          });
          return RawData(
              operationResult: OperationResult.success,
              data: 'Article successfully removed');
        } else {
          return RawData(
              operationResult: OperationResult.fail,
              data: 'there is no article to remove');
        }
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
      var result = await _userRef.doc(_firebaseAuth.currentUser!.uid).get();
      if (result.exists) {
        AmataUser amataUser =
            AmataUser.fromJson(result.data() as Map<String, dynamic>);
        return RawData(
            operationResult: OperationResult.success, data: amataUser);
      } else {
        return RawData(
            operationResult: OperationResult.fail,
            data: 'The use info didnt find');
      }
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  Future<AmataUser> getCurrentUser() async {
    try {
      var doc = await _userRef.doc(_firebaseAuth.currentUser!.uid).get();
      if (doc.exists) {
        AmataUser user = AmataUser.fromJson(doc.data() as Map<String, dynamic>);
        return user;
      } else {
        throw Exception('user cant find');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<RawData> getUserSavedArticle() async {
    try {
      log('*******getting user saved articles*******');
      var curentUserRawData =
          await _userRef.doc(_firebaseAuth.currentUser!.uid).get();
      if (curentUserRawData.exists) {
        AmataUser amataUser = AmataUser.fromJson(
            curentUserRawData.data() as Map<String, dynamic>);
        if (amataUser.savedArticles!.isNotEmpty) {
          return RawData(
              operationResult: OperationResult.success,
              data: amataUser.savedArticles);
        } else {
          return RawData(operationResult: OperationResult.success, data: []);
        }
      } else {
        return RawData(
            operationResult: OperationResult.fail,
            data: 'cannot find user saved article');
      }
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

// updates user email Adress
  Future<RawData> updateUserEmailAddress({
    required String newEmailAddres,
  }) async {
    try {
      log('Updating user Email Address ');

      /// updates user from auth section in firebase
      var result = await _firebaseAuth.currentUser!.updateEmail(newEmailAddres);

      ///[updates user email address in firebaseFireStore]
      await _userRef
          .doc(await _firebaseAuth.currentUser!.uid)
          .update({'emailAddrress': newEmailAddres});
      // gets last changes from fireStore
      var doc = await _userRef.doc(await _firebaseAuth.currentUser!.uid).get();
      // check if docs are exists and not's null
      if (doc.exists) {
        // converts user from json to User Model
        AmataUser user = AmataUser.fromJson(doc.data() as Map<String, dynamic>);
        return RawData(operationResult: OperationResult.success, data: user);
      }
      // returns unknown error because sth bad happens
      return RawData(
          operationResult: OperationResult.fail, data: 'some thing went wrong');
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }
  // add  or update bio section for user

  Future<RawData> updateOrAddBioForUser({required String bioText}) async {
    try {
      // updates value in firestore
      await _userRef
          .doc(_firebaseAuth.currentUser!.uid)
          .update({'bio': bioText});
      // gets last changes
      var res = await _userRef.doc(_firebaseAuth.currentUser!.uid).get();
      // user raw Data  
      Map<String, dynamic> userRawData = res.data() as Map<String, dynamic>;
      // last user changes 
      AmataUser user = AmataUser.fromJson(userRawData);
      return RawData(
          operationResult: OperationResult.success, data: user);
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  // updates userName in firestore
  Future<RawData> updateUserName({required String userName}) async {
    try {
      //updates username into fireStore
      var resualt = await _userRef
          .doc(_firebaseAuth.currentUser!.uid)
          .update({'userName': userName});
      // gets last changes from fireStore
      var rawData = await _userRef.doc(_firebaseAuth.currentUser!.uid).get();
      Map<String, dynamic> rawUser = rawData.data() as Map<String, dynamic>;
      // converts rawData to userProfile
      AmataUser amataUser = AmataUser.fromJson(rawUser);
      return RawData(operationResult: OperationResult.success, data: amataUser);
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  // update profile picture
  Future<RawData> updateUserProfile({required File profileImage}) async {
    try {
      // gets userName from fireStore
      String userName = await _userRef
          .doc(_firebaseAuth.currentUser!.uid)
          .get()
          .then((value) => value['userName']);

      // gets file name from path picked file
      String fileName = profileImage.path.split('/').last;
      // firebase storage path
      Reference profileBucket = _userStorageRef
          .ref()
          .child('profiles')
          .child(userName)
          .child(fileName);
      // deletes last image
      await profileBucket.delete();
      // uploads image to storage
      TaskSnapshot uploadTask = await profileBucket.putFile(profileImage);
      // gets last user changes from server
      var resualt = await _userRef.doc(_firebaseAuth.currentUser!.uid).get()
        ..data();
      // Last user  changes
      AmataUser user = AmataUser.fromJson(resualt as Map<String, dynamic>);

      return RawData(operationResult: OperationResult.success, data: resualt);
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }
}

bool _contains(List<Article> articles, Article articleMatcher) {
  for (int i = 0; i < articles.length; i++) {
    if (articles[i].title == articleMatcher.title) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}
