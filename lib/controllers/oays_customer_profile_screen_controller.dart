import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';

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
    userController = Get.put(OAYSUserController());

    setUserProfile();
  }

  void setUserProfile() {
    custUserName.text = userController.oaysUser.userName;
    // print(Get.find<OAYSAuthenticationController>().user!.email!);
    custEmailAddress.text =
        Get.find<OAYSAuthenticationController>().user!.email!;
    custLocation.text = userController.oaysUser.userLocation;
  }
}
