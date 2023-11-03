import 'package:get/get.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/screens/oays_offer_product_detail_screen.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';

class OAYSOfferNearMeScreenController extends GetxController {
  final RxList<OAYSOfferProduct> _offerProductList = <OAYSOfferProduct>[].obs;

  List<OAYSOfferProduct> get offerProductList => _offerProductList;

  set offerProductList(List<OAYSOfferProduct>? value) =>
      _offerProductList.value = value!;

  final isLoading = true.obs;
  final custLocation = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    if (isUserLoggedIn) {
      // await OAYSDatabaseService()
      //     .getOfferNearMeForUserByLocation(oaysUserLocation)
      //     .then((value) {
      //   offerProductList = value;
      //   isLoading.value = false;
      // });
      _offerProductList.bindStream(OAYSDatabaseService()
          .getOfferNearMeByLocationStream(oaysUserLocation));
      await Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
      });

      // Stream<List<Map<String, dynamic>>> documentsStream =
      //     OAYSDatabaseService().getUserIdStreamSubscription();
      // List<OAYSOfferProduct> offerList = [];
      // documentsStream.listen((documents) {
      //   for (int i = 0; i < documents.length; i++) {
      //     Stream<List<OAYSOfferProduct>> subdocumentsStream =
      //         OAYSDatabaseService()
      //             .getOfferIdStreamSubscription(documents[i]['_id']);
      //     subdocumentsStream.listen((subdocuments) {
      //       for (int i = 0; i < subdocuments.length; i++) {
      //         offerList.add(subdocuments[i]);
      //       }
      //       print(offerList.length);
      //       offerProductList = offerList;
      //     });
      //   }
      // });
    }
  }

  void goToOAYSOfferProductDetailScreen(OAYSOfferProduct offerProduct) {
    Get.to(() => OAYSOfferProductDetailScreen(), arguments: offerProduct);
  }
}
