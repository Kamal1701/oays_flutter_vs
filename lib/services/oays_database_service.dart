import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/models/oays_user_model.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Map<String, dynamic> timeTracker = {
    'createdDate': FieldValue.serverTimestamp(),
    'updatedDate': FieldValue.serverTimestamp()
  };

  Map<String, dynamic> updateTimeTracker = {
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
      // subDocRef.set({});
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

      return 'Success';
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return 'Unable to add product now. Please try again later.';
    }
  }

  Future<String> updateOfferProduct(
      OAYSOfferProduct op, String userId, String offerId) async {
    try {
      // String productSubCollectionId;
      // String userId = Get.find<OAYSAuthenticationController>().user!.uid;
      await _db
          .collection(productDetail)
          .doc(userId)
          .collection(offerProductDetail)
          .doc(offerId)
          .update(op.toMap())
          .whenComplete(() {
        _db
            .collection(productDetail)
            .doc(userId)
            .collection(offerProductDetail)
            .doc(offerId)
            .update(updateTimeTracker);
      });

      return 'Success';
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return 'Unable to add product now. Please try again later.';
    }
  }

  Stream<List<OAYSOfferProduct>> getOfferProductStream(String uid) {
    return _db
        .collection(productDetail)
        .doc(uid)
        .collection(offerProductDetail)
        .orderBy("updatedDate", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<OAYSOfferProduct> offerProduct = [];
      for (var element in query.docs) {
        offerProduct.add(OAYSOfferProduct.fromDocumentSnapshot(
            element as DocumentSnapshot<Map<String, dynamic>>));
      }
      return offerProduct;
    });
  }

  Future<List<OAYSOfferProduct>> getOfferProductNonStream(String userId) async {
    List<OAYSOfferProduct> productList = [];
    var querySnapshot = await _db
        .collection(productDetail)
        .doc(userId)
        .collection(offerProductDetail)
        // .orderBy("createdDate", descending: true)
        .get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      productList.add(OAYSOfferProduct.fromDocumentSnapshot(
          documentSnapshot as DocumentSnapshot<Map<String, dynamic>>));
    }

    return productList;
  }

  Future<String> deleteOfferProduct(String userId, String offerId) async {
    try {
      await _db
          .collection(productDetail)
          .doc(userId)
          .collection(offerProductDetail)
          .doc(offerId)
          .delete();
      return 'Success';
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return 'Unable to add product now. Please try again later.';
    }
  }

  Future<String> deleteOfferProductWithImageUrl(
      String userId, String offerId, String imageUrl) async {
    try {
      await _db
          .collection(productDetail)
          .doc(userId)
          .collection(offerProductDetail)
          .doc(offerId)
          .delete()
          .whenComplete(() {
        try {
          final storageReference =
              FirebaseStorage.instance.ref().child(imageUrl);
          storageReference.delete();
          // print("Image deleted successfully!");
        } catch (e) {
          print("Error deleting image: $e");
          // return e.toString();
        }
      });
      return 'Success';
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return 'Unable to delete the product now. Please try again later.';
    }
  }

  Future<void> deleteImageReference(String imageUrl) async {
    try {
      final storageReference = FirebaseStorage.instance.refFromURL(imageUrl);
      // ref().child(imageUrl);
      await storageReference.delete();
      // print("Image deleted successfully!");
    } catch (e) {
      print("Error deleting image: $e");
    }
  }
}
