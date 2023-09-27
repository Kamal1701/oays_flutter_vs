import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/screens/oays_all_offers_screen.dart';
import 'package:oaysflutter/screens/oays_customer_profile_screen.dart';
import 'package:oaysflutter/screens/oays_merchant_profile_screen.dart';
import 'package:oaysflutter/screens/oays_merchant_view_offer_screen.dart';
import 'package:oaysflutter/screens/oays_offer_add_screen.dart';
import 'package:oaysflutter/screens/oays_offer_near_me_screen.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSHomeScreenDrawerController extends GetxController {
  static OAYSHomeScreenDrawerController get instance => Get.find();

  var pageTitle = offerNearMe.obs;
  // var container;

  final selectedIndex = 0.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   setSelectedMenuIndex(selectedIndex.value);
  // }

  void setSelectedMenuIndex(int index) {
    selectedIndex.value = index;

    switch (selectedIndex.value) {
      case 0:
        // pageTitle.value = offerNearMe;
        // container = const OAYSOfferNearMeScreen();
        Get.back();
        Get.off(() => const OAYSOfferNearMeScreen());

      case 1:
        // pageTitle.value = allOffers;
        Get.back();
        Get.off(() => const OAYSAllOffersScreen());
      // container = const OAYSAllOffersScreen();

      case 2:
        // pageTitle.value = profile;
        // container = const OAYSCustomerProfileScreen();
        // ? const OAYSMerchantProfileScreen()
        // :
        Get.back();
        Get.off(() => const OAYSCustomerProfileScreen());

      case 3:
        // pageTitle.value = addOfferProduct;
        // container = OAYSOfferAddScreen();
        Get.back();
        Get.off(() => OAYSOfferAddScreen());

      case 4:
        // pageTitle.value = updateOffer;
        // container = OAYSMerchantViewOfferScreen();
        Get.back();
        Get.off(() => OAYSMerchantViewOfferScreen());
    }
    update();
  }
}
