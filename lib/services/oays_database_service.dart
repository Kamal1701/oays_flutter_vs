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
      final docRef = _db.collection(productDetail).doc(userId);
      await docRef.set(Map.of({'_id': userId}));

      final subDocRef = docRef.collection(offerProductDetail).doc();
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

  Stream<List<OAYSOfferProduct>> getOfferProductStreamByUserIdForMerchant(
      String uid) {
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

  // Stream<List<OAYSOfferProduct>> getOfferProductStreamByNearForUser2() {
  //   return _db
  //       .collection(productDetail)
  //       .doc()
  //       .collection(offerProductDetail)
  //       .orderBy("updatedDate", descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<OAYSOfferProduct> offerProduct = [];
  //     for (var element in query.docs) {
  //       offerProduct.add(OAYSOfferProduct.fromDocumentSnapshot(
  //           element as DocumentSnapshot<Map<String, dynamic>>));
  //     }
  //     print(offerProduct);
  //     return offerProduct;
  //   });
  // }

  Future<void> getOfferProductStreamByNearForUser3() async {
    final Stream<QuerySnapshot<Map<String, dynamic>>> parentStream =
        _db.collection(productDetail).snapshots();

    // final List<DocumentSnapshot<Map<String, dynamic>>> subcollectionDocuments =
    //     [];
    List<OAYSOfferProduct> offerProduct = [];

    parentStream.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      for (final DocumentSnapshot<Map<String, dynamic>> document
          in snapshot.docs) {
        final Stream<QuerySnapshot<Map<String, dynamic>>> subcollectionStream =
            document.reference.collection(offerProductDetail).snapshots();

        subcollectionStream.listen(
            (QuerySnapshot<Map<String, dynamic>> subcollectionSnapshot) {
          for (final DocumentSnapshot<
                  Map<String, dynamic>> subcollectionDocument
              in subcollectionSnapshot.docs) {
            // subcollectionDocuments.add(subcollectionDocument);
            offerProduct.add(
                OAYSOfferProduct.fromDocumentSnapshot(subcollectionDocument));
          }
          // print('getOfferProductStreamByNearForUser3');
          // print(offerProduct.first.isOfferImageBlank);
        });
      }
    });
  }

  Stream<List<OAYSOfferProduct>> getOfferProductStreamByNearForUser4() {
    // List<OAYSOfferProduct> offerProduct = [];

    return _db
        .collection(productDetail)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      List<OAYSOfferProduct> offerProduct = [];
      for (final DocumentSnapshot<Map<String, dynamic>> document
          in snapshot.docs) {
        document.reference.collection(offerProductDetail).snapshots().listen(
            (QuerySnapshot<Map<String, dynamic>> subcollectionSnapshot) {
          for (final DocumentSnapshot<
                  Map<String, dynamic>> subcollectionDocument
              in subcollectionSnapshot.docs) {
            // subcollectionDocuments.add(subcollectionDocument);
            offerProduct.add(
                OAYSOfferProduct.fromDocumentSnapshot(subcollectionDocument));
          }
        });
      }
      return offerProduct;
    });
  }

  Future<List<OAYSOfferProduct>> getOfferProductStreamByNearForUser() async {
    final CollectionReference collection = _db.collection(productDetail);
    List<OAYSOfferProduct> offerProduct = [];

    for (final QueryDocumentSnapshot document
        in await collection.get().then((value) => value.docs)) {
      final CollectionReference subcollection =
          document.reference.collection(offerProductDetail);
      final QuerySnapshot<Map<String, dynamic>> subcollectionQuerySnapshot =
          await subcollection.get() as QuerySnapshot<Map<String, dynamic>>;

      for (final QueryDocumentSnapshot subcollectionDocument
          in subcollectionQuerySnapshot.docs) {
        offerProduct.add(OAYSOfferProduct.fromDocumentSnapshot(
            subcollectionDocument as DocumentSnapshot<Map<String, dynamic>>));
      }
    }

    return offerProduct;
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
          // print("Error deleting image: $e");
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
}
