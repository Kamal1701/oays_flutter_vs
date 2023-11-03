import 'package:get/get.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/screens/oays_offer_product_detail_screen.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';

class OAYSAllOffersScreenController extends GetxController {
  final RxList<OAYSOfferProduct> _offerProductList = <OAYSOfferProduct>[].obs;

  List<OAYSOfferProduct> get offerProductList => _offerProductList;

  set offerProductList(List<OAYSOfferProduct>? value) =>
      _offerProductList.value = value!;

  final isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    if (isUserLoggedIn) {
      // await OAYSDatabaseService().getAllOffersForUserByAll().then((value) {
      //   offerProductList = value;
      //   isLoading.value = false;
      // });
      _offerProductList
          .bindStream(OAYSDatabaseService().getAllOffersForUserByStream());
      await Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false;
      });
    }
  }

  void goToOAYSOfferProductDetailScreen(OAYSOfferProduct offerProduct) {
    Get.to(() => OAYSOfferProductDetailScreen(), arguments: offerProduct);
  }
}
