import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/controllers/oays_offer_near_me_screen_controller.dart';
import 'package:oaysflutter/screens/oays_offer_near_me_screen.dart';

class OAYSAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OAYSAuthenticationController>(OAYSAuthenticationController(),
        permanent: true);

    // Get.lazyPut(() => OAYSOfferNearMeScreenController());
  }
}
