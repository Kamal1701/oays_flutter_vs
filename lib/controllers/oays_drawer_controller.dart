import 'package:get/get.dart';
import 'package:oaysflutter/screens/oays_offer_add_screen.dart';
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
        // container = const OAYSOffersNearMeScreen();
        container = OAYSOfferAddScreen();
      case 1:
        pageTitle.value = allOffers;
        // container = const OAYSAllOfferScreen();
        container = OAYSOfferAddScreen();
      case 2:
        pageTitle.value = profile;
        // container = const OAYSCustomerProfileScreen();
        container = OAYSOfferAddScreen();
      case 3:
        pageTitle.value = addOfferProduct;
        container = OAYSOfferAddScreen();
      case 4:
        pageTitle.value = updateOffer;
        // container = const OAYSMerchantViewOfferScreen();
        container = OAYSOfferAddScreen();
    }
    update();
  }

  updateAppBarTitle(String title) {
    pageTitle.value = title;
  }

  void onItemTap(int index) {}
}
