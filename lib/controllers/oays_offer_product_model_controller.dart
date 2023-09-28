import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/services/oays_database_service.dart';

class OAYSOfferProductController extends GetxController {
  // final _oaysOffer = OAYSOfferProduct('', '', true, '', '', '', '', '', '', '',
  //         '', '', '', '', '', '', '', '', '')
  //     .obs;

  // OAYSOfferProduct get oaysOffer => _oaysOffer.value;

  // set oaysOffer(OAYSOfferProduct? value) => _oaysOffer.value = value!;

  RxList<OAYSOfferProduct> _offerProductList = <OAYSOfferProduct>[].obs;

  List<OAYSOfferProduct> get offerProductList => _offerProductList;

  set offerProductList(List<OAYSOfferProduct>? value) =>
      _offerProductList.value = value!;

  final isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    String uid = Get.find<OAYSAuthenticationController>().user!.uid;
    // setOfferProductList(await OAYSDatabaseService().getOfferProductStream(uid));
    // await OAYSDatabaseService().getOfferProductNonStream(uid).then((value) {
    //   offerProductList = value;
    //   isLoading.value = false;
    // });

    _offerProductList.bindStream(
        OAYSDatabaseService().getOfferProductStreamByUserIdForMerchant(uid));
    isLoading.value = false; //stream coming from firebase
  }

  void setOfferProductList(List<OAYSOfferProduct> productList) {
    offerProductList.assignAll(productList);
  }
}
