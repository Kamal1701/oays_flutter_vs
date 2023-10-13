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
    if (emailAddress.text.isNotEmpty) {
      if (validateEmail(emailAddress.text)) {
        try {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: emailAddress.text)
              .whenComplete(() {
            showMessage(
                'Reset email sent successfully, please check your email.');
            emailAddress.text = '';
            Get.to(() => OAYSSignInScreen());
          });
        } on FirebaseAuthException catch (e) {
          showMessage(e.toString());
        }
      } else {
        showMessage('Please enter valid email address');
      }
    } else {
      showMessage('Please enter your email address');
    }
  }

  bool validateEmail(String email) {
    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }
}
