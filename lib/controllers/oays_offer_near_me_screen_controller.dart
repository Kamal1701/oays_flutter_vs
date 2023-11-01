import 'package:cloud_firestore/cloud_firestore.dart';
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
      await OAYSDatabaseService()
          .getOfferNearMeForUserByLocation(oaysUserLocation)
          .then((value) {
        offerProductList = value;
        isLoading.value = false;
      });
      // _offerProductList
      //     .bindStream(OAYSDatabaseService().getOfferNearMeForUserByStream());
      // isLoading.value = false;
      Stream<List<Map<String, dynamic>>> documentsStream =
          OAYSDatabaseService().getUserIdStreamSubscription();
      List<OAYSOfferProduct> offerList = [];
      documentsStream.listen((documents) {
        for (int i = 0; i < documents.length; i++) {
          Stream<List<OAYSOfferProduct>> subdocumentsStream =
              OAYSDatabaseService()
                  .geOfferIdStreamSubscription(documents[i]['_id']);
          subdocumentsStream.listen((subdocuments) {
            // offerProductList = subdocuments;

            for (int i = 0; i < subdocuments.length; i++) {
              offerList.add(subdocuments[i]);
            }
            print(offerList.length);
            offerProductList = offerList;
            // print(subdocuments.length);
          });
        }
        // subdocuments.forEach((map) {
        //   print({map['_id']});
        // });
      });
    }
  }

  void goToOAYSOfferProductDetailScreen(OAYSOfferProduct offerProduct) {
    Get.to(() => OAYSOfferProductDetailScreen(), arguments: offerProduct);
  }
}
