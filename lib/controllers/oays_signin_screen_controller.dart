import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/screens/oays_customer_signup_screen.dart';
import 'package:oaysflutter/screens/oays_home_screen.dart';
import 'package:oaysflutter/screens/oays_merchant_signup_screen.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';

class OAYSSignInScreenController extends GetxController {
  static OAYSSignInScreenController get instance => Get.find();
  final emailAddress = TextEditingController();
  final password = TextEditingController();
  final isLoginSuccess = false.obs;

  void oaysUserSignin() async {
    if (emailAddress.text.isEmpty) {
      _showMessage('Please enter your email address');
    } else if (password.text.isEmpty) {
      _showMessage('Please enter your password');
    } else {
      isLoginSuccess.value = true;

      String? error = await OAYSAuthenticationController.instance
          .oAYSCustomerLoginService(
        emailId: emailAddress.text.trim(),
        password: password.text.trim(),
      )
          .whenComplete(() {
        isLoginSuccess.value = false;
        clearScreen();
      });
      if (error != 'Success') {
        _showMessage(error.toString());
      } else {
        _showMessage('Logged-in successfully');
        Get.to(() => OAYSHomeScreen());
      }
    }
  }

  void clearScreen() {
    emailAddress.text = '';
    password.text = '';
  }

  void oaysCustomerSignUp() {
    Get.to(() => OAYSCustomerSignUpScreen());
  }

  void oaysMerchantSignUp() {
    Get.to(() => OAYSMerchantSignUpScreen());
  }

  void _showMessage(String info) {
    Get.snackbar(
      'Info',
      info,
      snackPosition: SnackPosition.BOTTOM,
      colorText: oaysFontColor,
      backgroundColor: boxFillColor,
    );
  }
}
