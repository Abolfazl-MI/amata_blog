import 'package:bloc/bloc.dart';
import 'package:blog_app/data/repositories/pref_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final PrefRepository _prefRepository = PrefRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SplashCubit() : super(UnknownState());
// cheat's wheather user is login  before or not
  cheackUserLogin() async {
    String? token = await _prefRepository.getToken();
    if (token == null) {
      emit(UnRegisteredState());
    }
    if (token != null) {
      String userUid = await _firebaseAuth.currentUser!.uid;
      print(token == userUid);
      print(await _firebaseAuth.currentUser!.email);
      if (token == userUid) {
        emit(RegisteredState());
      } else {
        emit(UnRegisteredState());
      }
    }
  }
}
