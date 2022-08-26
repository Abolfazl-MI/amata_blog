import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  CollectionReference _userRef = FirebaseFirestore.instance.collection('users');
  final user_storage = FirebaseStorage.instance;
  //  loges out user from firebase auth
  Future<RawData> logOut() async {
    try {
      log('**********Loging out user**********', name: 'Auth_Repository');
      var resualt = await FirebaseAuth.instance.signOut();
      return RawData(opereationResualt: OpereationResualt.succes, data: true);
    } on FirebaseAuthException catch (e) {
      return RawData(
          opereationResualt: OpereationResualt.fail, data: e.message);
    } catch (e) {
      return RawData(
          opereationResualt: OpereationResualt.fail, data: e.toString());
    }
  }

  // log in user with email and password
  Future<RawData> loginWithEmailAndPasword({
    required String email,
    required String password,
  }) async {
    try {
      log('**********Login user with {email:$email, password:$password }**********',
          name: 'Auth_Repository');

      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return RawData(
          opereationResualt: OpereationResualt.succes, data: user.user);
    } on FirebaseAuthException catch (e) {
      return RawData(
          opereationResualt: OpereationResualt.fail, data: e.message);
    } catch (e) {
      return RawData(
          opereationResualt: OpereationResualt.fail, data: e.toString());
    }
  }



  Future<RawData> signupWithEmailAndPssword(
      {required String email, required String password}) async {
    try {
      log('**********sign in user with {email:$email, password:$password }**********',
          name: 'Auth_Repository');

      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return RawData(
          opereationResualt: OpereationResualt.succes, data: user.user);
    } on FirebaseAuthException catch (e) {
      return RawData(
          opereationResualt: OpereationResualt.fail, data: e.message);
    } catch (e) {
      return RawData(
          opereationResualt: OpereationResualt.fail, data: e.toString());
    }
  }

  Future<RawData> forGetPassword({required String email}) async {
    try {
      log('**********user forget password with {email:$email}**********',
          name: 'Auth_Repository');

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return RawData(opereationResualt: OpereationResualt.succes, data: true);
    } on FirebaseAuthException catch (e) {
      return RawData(
          opereationResualt: OpereationResualt.fail, data: e.message);
    } catch (e) {
      return RawData(
          opereationResualt: OpereationResualt.fail, data: e.toString());
    }
  }
}
