import 'package:get/get.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/screens/oays_merchant_edit_offer_screen.dart';

class OAYSMerchantViewOfferScreenController extends GetxController {
  void goToOAYSMerchantEditOfferPage(OAYSOfferProduct offerProduct) {
    Get.to(() => OAYSMerchantModifyOfferScreen(), arguments: offerProduct);
  }
}
