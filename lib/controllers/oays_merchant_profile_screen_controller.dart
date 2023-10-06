import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';
import 'package:oaysflutter/screens/oays_home_screen.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSMerchantProfileScreenController extends GetxController {
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

  OAYSUserController userController =
      Get.put<OAYSUserController>(OAYSUserController());

  @override
  void onInit() {
    super.onInit();
    if (!isUserLogout) {
      userController = Get.put(OAYSUserController());

      setUserProfile();
    }
  }

  void setUserProfile() {
    merchantUserName.text = userController.oaysUser.userName;
    merchantEmailAddress.text =
        Get.find<OAYSAuthenticationController>().user!.email!;
    merchantLocation.text = userController.oaysUser.userLocation;
    merchantShopName.text = userController.oaysUser.shopName;
    merchantShopStreet.text = userController.oaysUser.shopStreetName;
    merchantShopCity.text = userController.oaysUser.shopCity;
    merchantShopState.text = userController.oaysUser.shopState;
    merchantShopPincode.text = userController.oaysUser.shopPincode;
  }

  void updateCustomerProfile() async {
    String error = await OAYSDatabaseService().updateOAYSMerchant(
        OAYSAuthenticationController.instance.user!.uid,
        merchantLocation.text,
        merchantShopName.text,
        merchantShopStreet.text,
        merchantShopCity.text,
        merchantShopState.text,
        merchantShopPincode.text);
    if (error == 'Success') {
      if (!isUserLogout) {
        userController = Get.find<OAYSUserController>();
        userController.oaysUser.userLocation = merchantLocation.text;
        userController.oaysUser.shopName = merchantShopName.text;
        userController.oaysUser.shopStreetName = merchantShopStreet.text;
        userController.oaysUser.shopCity = merchantShopCity.text;
        userController.oaysUser.shopState = merchantShopState.text;
        userController.oaysUser.shopPincode = merchantShopPincode.text;
        navigateToScreenIndex = 0;
        showMessage('Profile updated Successfully.');
        Get.offAll(() => OAYSHomeScreen());
      }
    } else {
      showMessage('Unable to update profile now, please try later.');
    }
  }

  void cancelUpdateProfile() {
    navigateToScreenIndex = 0;
    Get.offAll(() => OAYSHomeScreen());
  }
}
