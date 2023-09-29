import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_offer_near_me_screen_controller.dart';
import 'package:oaysflutter/screens/oays_all_offers_screen.dart';
import 'package:oaysflutter/screens/oays_customer_profile_screen.dart';
import 'package:oaysflutter/screens/oays_home_screen.dart';
import 'package:oaysflutter/screens/oays_merchant_view_offer_screen.dart';
import 'package:oaysflutter/screens/oays_offer_add_screen.dart';
import 'package:oaysflutter/screens/oays_offer_near_me_screen.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSHomeScreenDrawerController extends GetxController {
  static OAYSHomeScreenDrawerController get instance => Get.find();

  var pageTitle = offerNearMe.obs;
  var container;

  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.put(OAYSOfferNearMeScreenController());
  }

  final screens = [
    // Get.offAll(() => OAYSOfferNearMeScreen()),
    // Get.offAll(() => OAYSAllOffersScreen()),
    // Get.off(() => const OAYSCustomerProfileScreen()),
    // Get.offAll(() => OAYSOfferAddScreen()),
    // Get.off(() => OAYSMerchantViewOfferScreen())
    OAYSOfferNearMeScreen(),
    OAYSAllOffersScreen(),
    OAYSCustomerProfileScreen(),
    OAYSOfferAddScreen(),
    OAYSMerchantViewOfferScreen()
  ];

  final screenTitle = [
    offerNearMe,
    allOffers,
    profile,
    addOfferProduct,
    updateOffer
  ];

  onSelectedItem(int index) {
    selectedIndex.value = index;
    Get.back();
    update();
  }

  setSelectedMenuIndex(int index) {
    // selectedIndex.value = index;
    navigateToScreenIndex = index;
    // Get.back();
    // switch (selectedIndex.value) {
    switch (index) {
      case 0:
        // Get.back();
        // Get.offAll(() => OAYSOfferNearMeScreen());
        // Get.off(() => OAYSOfferNearMeScreen());
        return OAYSOfferNearMeScreen();

      case 1:
        // Get.back();
        // Get.offAll(() => OAYSAllOffersScreen());
        return OAYSAllOffersScreen();

      case 2:
        // Get.back();
        // Get.offAll(() => OAYSCustomerProfileScreen());
        return OAYSCustomerProfileScreen();

      case 3:
        // Get.back();
        // Get.offAll(() => OAYSOfferAddScreen());
        return OAYSOfferAddScreen();

      case 4:
        // Get.back();
        // Get.off(() => OAYSMerchantViewOfferScreen());
        return OAYSMerchantViewOfferScreen();
    }
    update();
  }
}
