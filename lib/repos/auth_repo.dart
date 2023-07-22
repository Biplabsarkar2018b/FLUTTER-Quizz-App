import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizz/utils/snackbar.dart';

final authRepoProvider = Provider((ref) {
  return AuthRepo(firebaseAuth: FirebaseAuth.instance);
});

class AuthRepo {
  final FirebaseAuth _firebaseAuth;
  AuthRepo({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      showSnackbar(message: 'Logged In', context: context);
      //navigate to home screen
    } catch (signInError) {
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        showSnackbar(message: 'Logged In', context: context);
        //navigate to home screen
      } catch (e) {
        print(e);
        showSnackbar(
          message: e.toString(),
          context: context,
        );
      }
    }
  }
}
