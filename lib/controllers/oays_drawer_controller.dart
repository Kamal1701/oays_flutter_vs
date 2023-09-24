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
  var container;

  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    setSelectedMenuIndex(selectedIndex.value);
  }

  void setSelectedMenuIndex(int index) {
    selectedIndex.value = index;

    switch (selectedIndex.value) {
      case 0:
        pageTitle.value = offerNearMe;
        container = const OAYSOfferNearMeScreen();

      case 1:
        pageTitle.value = allOffers;
        container = const OAYSAllOffersScreen();

      case 2:
        pageTitle.value = profile;
        container = const OAYSCustomerProfileScreen();
      // ? const OAYSMerchantProfileScreen()
      // :

      case 3:
        pageTitle.value = addOfferProduct;
        container = OAYSOfferAddScreen();

      case 4:
        pageTitle.value = updateOffer;
        container = OAYSMerchantViewOfferScreen();
    }
    update();
  }

  // void onItemTap(int index) {
  //   if (selectedIndex.value == 0) {
  //     container = const OAYSOfferNearMeScreen();
  //     update();
  //   } else if (selectedIndex.value == 1) {
  //     container = const OAYSAllOffersScreen();
  //     update();
  //   } else if (selectedIndex.value == 2) {
  //     container = const OAYSAllOffersScreen();
  //     update();
  //   } else if (selectedIndex.value == 3) {
  //     container = OAYSOfferAddScreen();
  //     update();
  //   } else if (selectedIndex.value == 4) {
  //     container = OAYSMerchantViewOfferScreen();
  //     update();
  //   }
  // }
}
