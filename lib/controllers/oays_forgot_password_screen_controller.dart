import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/screens/oays_signin_screen.dart';

class OAYSForgotPasswordScreenController extends GetxController {
  final emailAddress = TextEditingController();

  void backToSignInScreen() {
    emailAddress.text = '';
    Get.to(() => OAYSSignInScreen());
  }

  void sendPasswordResetEmail() {}
}
