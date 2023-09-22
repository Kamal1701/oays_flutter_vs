import 'package:get/get.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSHomeScreenDrawerController extends GetxController {
  static OAYSHomeScreenDrawerController get instance => Get.find();

  var pageTitle = offerNearMe.obs;

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
      case 1:
        pageTitle.value = allOffers;
      // container = const OAYSAllOfferScreen();
      case 2:
        pageTitle.value = profile;
      // container = const OAYSCustomerProfileScreen();
      case 3:
        pageTitle.value = addOfferProduct;
      // container = const OAYSAddOfferScreen();
      case 4:
        pageTitle.value = updateOffer;
      // container = const OAYSMerchantViewOfferScreen();
    }
    update();
  }

  updateAppBarTitle(String title) {
    pageTitle.value = title;
  }

  void onItemTap(int index) {}
}
