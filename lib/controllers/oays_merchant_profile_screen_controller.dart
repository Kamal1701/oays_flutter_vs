import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';

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
    userController = Get.put(OAYSUserController());

    setUserProfile();
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
}
