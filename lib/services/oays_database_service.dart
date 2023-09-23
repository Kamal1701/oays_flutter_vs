import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/models/oays_user_model.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Map<String, dynamic> timeTracker = {
    'createdDate': FieldValue.serverTimestamp(),
    'updatedDate': FieldValue.serverTimestamp()
  };

  Future<String?> addOAYSCustomer(OAYSUser user) async {
    try {
      String? status;
      CollectionReference collectRef = _db.collection(customerProfile);
      await collectRef
          .doc(user.userId)
          .set(user.toMap())
          .whenComplete(() async {
        await collectRef.doc(user.userId).update(timeTracker).whenComplete(() {
          status = 'Success';
        });
      });
      return status;
    } on FirebaseException catch (e) {
      return e.message;
    } catch (e) {
      return 'Error in add customer';
    }
  }

  Future<String?> addOAYSMerchant(OAYSUser user) async {
    try {
      String? status;
      CollectionReference collectRef = _db.collection(customerProfile);
      await collectRef.doc(user.userId).set(user.toMap()).whenComplete(() {
        collectRef
            .doc(user.userId)
            .update(timeTracker)
            .whenComplete(() => status = 'Success');
      });
      return status;
    } on FirebaseException catch (e) {
      return e.message;
    } catch (e) {
      return 'Error in add customer';
    }
  }

  Future<OAYSUser?> getCustomer(String authId) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection("CustomerProfile").doc(authId).get();
      if (snapshot.exists) {
        final Map<String, dynamic> data =
            snapshot.data() as Map<String, dynamic>;
        return OAYSUser.fromMap(data);
      }
    } catch (e) {
      //
    }
    return null;
  }

  Future<String> getOfferProductId(String userId) async {
    try {
      // String userId = Get.find<OAYSAuthenticationController>().user!.uid;
      final docRef = _db.collection(productDetail).doc(userId);
      await docRef.set(Map.of({'_id': userId}));

      final subDocRef = docRef.collection(offerProductDetail).doc();
      subDocRef.set({});
      final subDocRefId = subDocRef.id;
      return subDocRefId;
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return 'Unable to add product now. Please try again later.';
    }
  }

  Future<String> addOfferProduct(
      OAYSOfferProduct op, String userId, String offerId) async {
    try {
      // String productSubCollectionId;
      // String userId = Get.find<OAYSAuthenticationController>().user!.uid;
      await _db
          .collection(productDetail)
          .doc(userId)
          .collection(offerProductDetail)
          .doc(offerId)
          .set(op.toMap())
          .whenComplete(() {
        _db
            .collection(productDetail)
            .doc(userId)
            .collection(offerProductDetail)
            .doc(offerId)
            .update(timeTracker);
      });

      // await _db
      //     .collection(productDetail)
      //     .doc(userId)
      //     .set(Map.of({'_id': userId}))
      //     .whenComplete(() async {
      //   productSubCollectionId = _db
      //       .collection(productDetail)
      //       .doc(userId)
      //       .collection(offerProductDetail)
      //       .doc()
      //       .id;
      //   _db
      //       .collection(productDetail)
      //       .doc(userId)
      //       .collection(offerProductDetail)
      //       .doc(productSubCollectionId)
      //       .set(op.toMap())
      //       .whenComplete(() {
      //     timeTracker['offerProductId'] = productSubCollectionId;
      //     _db
      //         .collection(productDetail)
      //         .doc(userId)
      //         .collection(offerProductDetail)
      //         .doc(productSubCollectionId)
      //         .update(timeTracker);
      //     // _db
      //     //     .collection(productDetail)
      //     //     .doc(userId)
      //     //     .collection(offerProductDetail)
      //     //     .doc(productSubCollectionId)
      //     //     .update(
      //     //       Map.of(
      //     //         {'offerProductId': productSubCollectionId},
      //     //       ),
      //     //     );
      //     // Get.offAll(() => const OAYSSignInScreen());
      //   });
      // });
      return 'Success';
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return 'Unable to add product now. Please try again later.';
    }
  }
}
