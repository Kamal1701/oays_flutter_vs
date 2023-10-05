import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';
import 'package:oaysflutter/models/oays_user_model.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';

class OAYSAuthenticationController extends GetxController {
  static OAYSAuthenticationController get instance => Get.find();
  final _mauth = FirebaseAuth.instance;
  // late FirebaseAuth _mauth;
  // Rx<User?> _firebaseUser = Rx<User?>(null);
  final _firebaseUser = Rx<User?>(null);

  User? get user => _firebaseUser.value;

  @override
  onInit() {
    super.onInit();
    _firebaseUser.bindStream(_mauth.authStateChanges());
  }

  Future<String?> oAYSCustomerLoginService({
    required String emailId,
    required String password,
  }) async {
    try {
      await _mauth
          .signInWithEmailAndPassword(email: emailId, password: password)
          .whenComplete(
              () => _firebaseUser.bindStream(_mauth.authStateChanges()));
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email. Please sign up';
      } else if (e.code == 'wrong-password') {
        return 'Invalid password';
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return 'Invalid email id or password';
      } else {
        return e.message.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> oAYSCreateCustomerProfile(String emailId, String password,
      String userName, String location, bool isMerchant) async {
    String? status;
    try {
      await _mauth
          .createUserWithEmailAndPassword(email: emailId, password: password)
          .then((value) async {
        OAYSUser oaysUser = OAYSUser(
          value.user!.uid,
          userName,
          location,
          isMerchant,
          '',
          '',
          '',
          '',
          '',
        );
        status = await OAYSDatabaseService().addOAYSCustomer(oaysUser);
      });

      return status;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account is already exist';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> oAYSCreateMerchantProfile(
    String emailId,
    String password,
    String userName,
    String location,
    String shopName,
    String shopStreet,
    String shopCity,
    String shopState,
    String shopPincode,
    bool isMerchant,
  ) async {
    String? status;
    try {
      await _mauth
          .createUserWithEmailAndPassword(email: emailId, password: password)
          .then((value) async {
        OAYSUser oaysUser = OAYSUser(
          value.user!.uid,
          userName,
          location,
          isMerchant,
          shopName,
          shopStreet,
          shopCity,
          shopState,
          shopPincode,
        );
        status = await OAYSDatabaseService().addOAYSCustomer(oaysUser);
      });

      return status;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account is already exist';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  void userSignOut() async {
    try {
      navigateToScreenIndex = 0;
      Get.find<OAYSUserController>().clear();
      _firebaseUser.value = null;
      await _mauth.signOut();
    } catch (e) {
      Get.snackbar(
        'Info',
        'Unable to sign-out now',
        snackPosition: SnackPosition.BOTTOM,
        colorText: oaysFontColor,
        backgroundColor: boxFillColor,
      );
    }
  }
}
