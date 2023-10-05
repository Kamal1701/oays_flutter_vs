import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/models/oays_user_model.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';

class OAYSUserController extends GetxController {
  final _oaysUser = OAYSUser('', '', '', false, '', '', '', '', '').obs;

  OAYSUser get oaysUser => _oaysUser.value;

  set oaysUser(OAYSUser? value) => _oaysUser.value = value!;

  @override
  void onInit() async {
    super.onInit();
    if (!isUserLogout) {
      oaysUser = await OAYSDatabaseService()
          .getCustomer(Get.find<OAYSAuthenticationController>().user!.uid);
    }
  }

  void clear() {
    _oaysUser.value = OAYSUser('', '', '', false, '', '', '', '', '');
  }
}
