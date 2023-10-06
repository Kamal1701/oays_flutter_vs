import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';

class OAYSOfferProductController extends GetxController {
  // RxList<OAYSOfferProduct> _offerProductList = <OAYSOfferProduct>[].obs;
  final _offerProductList = <OAYSOfferProduct>[].obs;

  List<OAYSOfferProduct> get offerProductList => _offerProductList;

  set offerProductList(List<OAYSOfferProduct>? value) =>
      _offerProductList.value = value!;

  final isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    // String uid = Get.find<OAYSAuthenticationController>().user!.uid;
    if (!isUserLogout) {
      String uId = OAYSAuthenticationController.instance.user!.uid;
      // _offerProductList.bindStream(
      //     OAYSDatabaseService().getOfferProductStreamByUserIdForMerchant(uId));

      await OAYSDatabaseService()
          .getOfferProductStreamByUserIdForMerchant(uId)
          .then((value) {
        offerProductList = value;
        isLoading.value = false;
      });
      // isLoading.value = false;
    }
  }

  void clearProduct() {
    _offerProductList.value = [];
  }
}
