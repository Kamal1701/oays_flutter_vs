import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/screens/oays_signin_screen.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSMerchantSignUpController extends GetxController {
  static OAYSMerchantSignUpController get instance => Get.find();

  final merchantUserName = TextEditingController();
  final merchantEmailAddress = TextEditingController();
  final merchantPassword = TextEditingController();
  final merchantLocation = TextEditingController();
  final merchantShopName = TextEditingController();
  final merchantShopStreet = TextEditingController();
  final merchantShopCity = TextEditingController();
  final merchantShopState = TextEditingController();
  final merchantShopPincode = TextEditingController();

  final isRegisterSuccess = false.obs;

  createMerchantProfile() async {
    if (merchantUserName.text.isEmpty) {
      _showMessage('Please enter your user name');
    } else if (merchantEmailAddress.text.isEmpty) {
      _showMessage('Please enter your email address');
    } else if (merchantPassword.text.isEmpty) {
      _showMessage('Please enter your password');
    } else if (merchantLocation.text.isEmpty) {
      _showMessage('Please enter your location');
    } else if (merchantShopName.text.isEmpty) {
      _showMessage('Please enter your shop name');
    } else if (merchantShopStreet.text.isEmpty) {
      _showMessage('Please enter your shop street');
    } else if (merchantShopCity.text.isEmpty) {
      _showMessage('Please enter your shop city');
    } else if (merchantShopState.text.isEmpty) {
      _showMessage('Please enter your shop state');
    } else if (merchantShopPincode.text.isEmpty) {
      _showMessage('Please enter your shop pincode');
    } else {
      isRegisterSuccess.value = true;

      String? error = await OAYSAuthenticationController.instance
          .oAYSCreateMerchantProfile(
            merchantEmailAddress.text.trim(),
            merchantPassword.text.trim(),
            merchantUserName.text.trim(),
            merchantLocation.text.trim(),
            merchantShopName.text.trim(),
            merchantShopStreet.text.trim(),
            merchantShopCity.text.trim(),
            merchantShopState.text.trim(),
            merchantShopPincode.text.trim(),
            isMerchant,
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
    merchantEmailAddress.text = '';
    merchantPassword.text = '';
    merchantUserName.text = '';
    merchantLocation.text = '';
    merchantShopName.text = '';
    merchantShopStreet.text = '';
    merchantShopCity.text = '';
    merchantShopState.text = '';
    merchantShopPincode.text = '';
  }
}
