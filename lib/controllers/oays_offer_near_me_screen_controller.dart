import 'package:get/get.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/screens/oays_offer_product_detail_screen.dart';
import 'package:oaysflutter/services/oays_database_service.dart';

class OAYSOfferNearMeScreenController extends GetxController {
  RxList<OAYSOfferProduct> _offerProductList = <OAYSOfferProduct>[].obs;

  List<OAYSOfferProduct> get offerProductList => _offerProductList;

  set offerProductList(List<OAYSOfferProduct>? value) =>
      _offerProductList.value = value!;

  final isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    _offerProductList.bindStream(
        OAYSDatabaseService().getOfferProductStreamByNearForUser4());
    // isLoading.value = false; //stream coming from firebase
    // await OAYSDatabaseService()
    //     .getOfferProductStreamByNearForUser()
    //     .then((value) {
    //   offerProductList = value;
    //   isLoading.value = false;
    // });
    // await OAYSDatabaseService().getOfferProductStreamByNearForUser3();
  }

  void setOfferProductList(List<OAYSOfferProduct> productList) {
    offerProductList.assignAll(productList);
  }

  void goToOAYSOfferProductDetailScreen(OAYSOfferProduct offerProduct) {
    Get.to(() => OAYSOfferProductDetailScreen(), arguments: offerProduct);
  }
}
