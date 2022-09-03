import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/core.dart';
import 'package:blog_app/data/models/user/user_modle.dart';
import 'package:blog_app/data/repositories/pref_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:blog_app/core/firebase_erro_helper.dart';

class AuthRepository {
  final PrefRepository _prefRepository;
  final FirebaseAuth _firebaseAuth;
  // FirebaseFirestore.instance.collection('users')
  AuthRepository(
      {FirebaseAuth? firebaseAuth,
      PrefRepository? prefRepository,
      FirebaseFirestore? userCollectionRef})
      : _prefRepository = prefRepository ?? PrefRepository(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  //  loges out user from firebase auth
  Future<RawData> logOut() async {
    try {
      log('**********Loging out user**********', name: 'Auth_Repository');
      var resualt = await _firebaseAuth.signOut();
      return RawData(operationResult: OperationResult.success, data: true);
    } on FirebaseAuthException catch (e) {
      String message = e.getErrorMessage();

      return RawData(operationResult: OperationResult.fail, data: message);
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  // log in user with email and password
  Future<RawData> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      log('**********Login user with {email:$email, password:$password }**********',
          name: 'Auth_Repository');

      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await _prefRepository.saveToken(user.credential!.token.toString());
      String userUid = user.user!.uid;
      await _prefRepository.saveToken(userUid);
      return RawData(operationResult: OperationResult.success, data: user.user);
    } on FirebaseAuthException catch (e) {
      String message = e.getErrorMessage();
      return RawData(operationResult: OperationResult.fail, data: message);
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  Future<RawData> signupWithEmail(
      {required String email, required String password}) async {
    try {
      log('**********sign in user with {email:$email, password:$password }**********',
          name: 'Auth_Repository');

      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      String userUid = user.user!.uid;
      await _prefRepository.saveToken(userUid);
      return RawData(operationResult: OperationResult.success, data: user.user);
    } on FirebaseAuthException catch (e) {
      String message = e.getErrorMessage();

      return RawData(operationResult: OperationResult.fail, data: message);
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

  Future<RawData> forGetPassword({required String email}) async {
    try {
      log('**********user forget password with {email:$email}**********',
          name: 'Auth_Repository');

      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return RawData(operationResult: OperationResult.success, data: true);
    } on FirebaseAuthException catch (e) {
      String message = e.getErrorMessage();

      return RawData(operationResult: OperationResult.fail, data: message);
    } catch (e) {
      return RawData(operationResult: OperationResult.fail, data: e.toString());
    }
  }

}
