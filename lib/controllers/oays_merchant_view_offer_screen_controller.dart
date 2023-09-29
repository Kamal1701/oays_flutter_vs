import 'package:get/get.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/screens/oays_merchant_edit_offer_screen.dart';

class OAYSMerchantViewOfferScreenController extends GetxController {
  goToOAYSMerchantEditOfferPage(OAYSOfferProduct offerProduct) {
    print(offerProduct.offerProductName);
    Get.to(() => OAYSMerchantModifyOfferScreen(), arguments: offerProduct);
  }
}
