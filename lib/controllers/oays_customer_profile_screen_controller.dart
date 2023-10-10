import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';
import 'package:oaysflutter/screens/oays_home_screen.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSCustomerProfileScreenController extends GetxController {
  final custUserName = TextEditingController();
  final custEmailAddress = TextEditingController();
  final custLocation = TextEditingController();

  final isRegisterSuccess = false.obs;

  OAYSUserController userController =
      Get.put<OAYSUserController>(OAYSUserController());

  @override
  void onInit() {
    super.onInit();
    // if (!isUserLogout) {
    print('customer profile controller $isUserLoggedIn');
    if (isUserLoggedIn) {
      print('customer profile controller on init called');
      userController = Get.put(OAYSUserController());
      oaysUserLocation = userController.oaysUser.userLocation;
      setUserProfile();
    }
  }

  void setUserProfile() {
    custUserName.text = userController.oaysUser.userName;
    custEmailAddress.text =
        Get.find<OAYSAuthenticationController>().user!.email!;
    custLocation.text = userController.oaysUser.userLocation;
  }

  void updateCustomerProfile() async {
    String error = await OAYSDatabaseService().updateOAYSCustomer(
        OAYSAuthenticationController.instance.user!.uid, custLocation.text);
    if (error == 'Success') {
      // if (!isUserLogout) {
      if (isUserLoggedIn) {
        userController = Get.find<OAYSUserController>();
        userController.oaysUser.userLocation = custLocation.text;
        print('update customer profile ${custLocation.text}');
        oaysUserLocation = custLocation.text;
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
