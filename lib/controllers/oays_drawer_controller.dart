import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/controllers/oays_offer_near_me_screen_controller.dart';
import 'package:oaysflutter/screens/oays_all_offers_screen.dart';
import 'package:oaysflutter/screens/oays_customer_profile_screen.dart';
import 'package:oaysflutter/screens/oays_merchant_profile_screen.dart';
import 'package:oaysflutter/screens/oays_merchant_view_offer_screen.dart';
import 'package:oaysflutter/screens/oays_offer_add_screen.dart';
import 'package:oaysflutter/screens/oays_offer_near_me_screen.dart';
import 'package:oaysflutter/screens/oays_signin_screen.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSHomeScreenDrawerController extends GetxController {
  static OAYSHomeScreenDrawerController get instance => Get.find();

  var pageTitle = offerNearMe.obs;
  final selectedIndex = 0.obs;
  final popUpMenuIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.put(OAYSOfferNearMeScreenController());
  }

  final screenTitle = [
    offerNearMe,
    allOffers,
    addOfferProduct,
    updateOffer,
    profile,
    profileMerchant,
  ];

  void onSelectedItem(int index) {
    selectedIndex.value =
        navigateToScreenIndex != 0 ? navigateToScreenIndex : index;
    Get.back();
    update();
  }

  void onPopupMenuItemSelection(int index, bool isMerchant) {
    popUpMenuIndex.value = index;
    switch (popUpMenuIndex.value) {
      case 0:
        isMerchant
            ? Get.to(() => OAYSMerchantProfileScreen())
            : Get.to(() => OAYSCustomerProfileScreen());
        break;

      case 1:
        oaysUserSignOut();
        Get.deleteAll();
        Get.offAll(() => OAYSSignInScreen());
        break;
    }
  }

  String getAppBarTitle() {
    return screenTitle[selectedIndex.value = navigateToScreenIndex != 0
        ? navigateToScreenIndex
        : selectedIndex.value];
  }

  setSelectedMenuIndex(int index) {
    selectedIndex.value =
        navigateToScreenIndex != 0 ? navigateToScreenIndex : index;
    update();
    switch (selectedIndex.value) {
      case 0:
        return OAYSOfferNearMeScreen();

      case 1:
        return OAYSAllOffersScreen();

      case 2:
        return OAYSOfferAddScreen();

      case 3:
        return OAYSMerchantViewOfferScreen();
    }
  }

  void oaysUserSignOut() {
    Get.find<OAYSAuthenticationController>().userSignOut();
  }
}
