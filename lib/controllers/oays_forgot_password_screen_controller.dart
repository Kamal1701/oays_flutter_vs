import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/screens/oays_signin_screen.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSForgotPasswordScreenController extends GetxController {
  final emailAddress = TextEditingController();

  void backToSignInScreen() {
    emailAddress.text = '';
    Get.to(() => OAYSSignInScreen());
  }

  Future<void> resetEmailPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailAddress.text)
          .whenComplete(() => showMessage(
              'Reset email sent successfully, please check your email.'));
    } on FirebaseAuthException catch (e) {
      showMessage(e.toString());
    }
  }
}
