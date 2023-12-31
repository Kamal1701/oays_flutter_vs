import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/models/oays_user_model.dart';
import 'package:oaysflutter/screens/oays_customer_signup_screen.dart';
import 'package:oaysflutter/screens/oays_forgot_password_screen.dart';
import 'package:oaysflutter/screens/oays_home_screen.dart';
import 'package:oaysflutter/screens/oays_merchant_signup_screen.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSSignInScreenController extends GetxController {
  static OAYSSignInScreenController get instance => Get.find();
  final emailAddress = TextEditingController();
  final password = TextEditingController();
  final isLoginSuccess = false.obs;

//Get UserLocation after successfull login
  final _oaysUser = OAYSUser('', '', '', false, '', '', '', '', '').obs;

  OAYSUser get oaysUser => _oaysUser.value;

  set oaysUser(OAYSUser? value) => _oaysUser.value = value!;

  void oaysUserSignin() async {
    if (emailAddress.text.isEmpty) {
      showMessage('Please enter your email address');
    } else if (password.text.isEmpty) {
      showMessage('Please enter your password');
    } else {
      isLoginSuccess.value = true;

      String? error = await OAYSAuthenticationController.instance
          .oAYSCustomerLoginService(
        emailId: emailAddress.text.trim(),
        password: password.text.trim(),
      )
          .whenComplete(() async {
        isUserLoggedIn = true;
        oaysUser = await OAYSDatabaseService()
            .getCustomer(Get.find<OAYSAuthenticationController>().user!.uid);
        oaysUserLocation = oaysUser.userLocation;
        isLoginSuccess.value = false;
        clearScreen();
      });
      if (error != 'Success') {
        showMessage(error.toString());
      } else {
        showMessage('Logged-in successfully');
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

  void oaysResetPassword() {
    Get.to(() => OAYSForgotPasswordScreen());
  }
}
