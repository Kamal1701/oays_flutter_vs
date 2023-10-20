import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';

class OAYSAuthBinding extends Bindings {
  @override
  void dependencies() {
    //Create OAYSAuthentication Controller object permanently
    Get.put<OAYSAuthenticationController>(OAYSAuthenticationController(),
        permanent: true);
  }
}
