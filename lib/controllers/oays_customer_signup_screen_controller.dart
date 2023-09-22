import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/screens/oays_signin_screen.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSCustomerSignUpController extends GetxController {
  static OAYSCustomerSignUpController get instance => Get.find();

  final custUserName = TextEditingController();
  final custEmailAddress = TextEditingController();
  final custPassword = TextEditingController();
  final custLocation = TextEditingController();

  final isRegisterSuccess = false.obs;

  createCustomerProfile() async {
    if (custUserName.text.isEmpty) {
      _showMessage('Please enter your user name');
    } else if (custEmailAddress.text.isEmpty) {
      _showMessage('Please enter your email address');
    } else if (custPassword.text.isEmpty) {
      _showMessage('Please enter your password');
    } else if (custLocation.text.isEmpty) {
      _showMessage('Please enter your location');
    } else {
      isRegisterSuccess.value = true;

      String? error = await OAYSAuthenticationController.instance
          .oAYSCreateCustomerProfile(
            custEmailAddress.text.trim(),
            custPassword.text.trim(),
            custUserName.text.trim(),
            custLocation.text.trim(),
            !isMerchant,
          )
          .whenComplete(() => isRegisterSuccess.value = false);
      if (error != 'Success') {
        _showMessage(error.toString());
      } else {
        _showMessage('user created successfully');
        _clearScreen();
        Get.to(() => OAYSSignInScreen());
      }
    }
  }

  _showMessage(String info) {
    Get.snackbar(
      'Info',
      info,
      snackPosition: SnackPosition.BOTTOM,
      colorText: oaysFontColor,
      backgroundColor: boxFillColor,
    );
  }

  _clearScreen() {
    custUserName.text = '';
    custEmailAddress.text = '';
    custPassword.text = '';
    custLocation.text = '';
  }
}
