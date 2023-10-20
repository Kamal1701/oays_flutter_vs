import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
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

//Add OAYS Customer into customer_profile collection while register as customer
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

//Update the OAYS customer location into customer_profile collection from profile screen
  Future<String> updateOAYSCustomer(String uId, String location) async {
    try {
      Map<String, dynamic> locationUpdate = {
        'userLocation': location,
        'updatedDate': FieldValue.serverTimestamp()
      };
      CollectionReference collectRef = _db.collection(customerProfile);
      await collectRef.doc(uId).update(locationUpdate);
      return 'Success';
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return 'Error in update customer location';
    }
  }

//update OAYS merchant profile into customer_profile collection from profile screen
  Future<String> updateOAYSMerchant(String uId, String location, String sName,
      String sStreetName, String sCity, String sState, String sPincode) async {
    try {
      Map<String, dynamic> locationUpdate = {
        'userLocation': location,
        'shopName': sName,
        'shopStreetName': sStreetName,
        'shopCity': sCity,
        'shopState': sState,
        'shopPincode': sPincode,
        'updatedDate': FieldValue.serverTimestamp()
      };
      CollectionReference collectRef = _db.collection(customerProfile);
      await collectRef.doc(uId).update(locationUpdate);

      return 'Success';
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return 'Error in update customer profile';
    }
  }

//Add OAYS merchant into customer_profile collection while register as Merchant
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

//Get OAYSCustomer profile
  //Purpose
  //To update navigation drawer header
  //Filter the offer near me
  //To update the profile screen
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

  //Create new document id under the subcollection (offer_Detail) into product_detail collection
  //this subcollection document id will be used to add new offer product under this id

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

//Add new offer product into offerproductdetail subcollection using sub collection
//document id which is created from getOfferProductId function

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

  //Update the offer product from Update screen

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

  Future<List<OAYSOfferProduct>> getOfferProductStreamByUserIdForMerchant(
      String uid) async {
    final DocumentReference collection = _db.collection(productDetail).doc(uid);
    List<OAYSOfferProduct> offerProduct = [];

    // for (final QueryDocumentSnapshot document
    //     in await collection.get().then((value) => value.docs)) {
    final CollectionReference subcollection =
        collection.collection(offerProductDetail);
    final QuerySnapshot<Map<String, dynamic>> subcollectionQuerySnapshot =
        await subcollection.orderBy("updatedDate", descending: true).get()
            as QuerySnapshot<Map<String, dynamic>>;

    for (final QueryDocumentSnapshot subcollectionDocument
        in subcollectionQuerySnapshot.docs) {
      offerProduct.add(OAYSOfferProduct.fromDocumentSnapshotWithSymbol(
          subcollectionDocument as DocumentSnapshot<Map<String, dynamic>>));
    }
    // }

    return offerProduct;
  }

  Stream<List<OAYSOfferProduct>> getOfferProductStreamByUserIdForMerchant2(
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
        offerProduct.add(OAYSOfferProduct.fromDocumentSnapshotWithSymbol(
            element as DocumentSnapshot<Map<String, dynamic>>));
      }
      return offerProduct;
    });
  }

  // Future<void> getOfferProductStreamByNearForUser3() async {
  //   final Stream<QuerySnapshot<Map<String, dynamic>>> parentStream =
  //       _db.collection(productDetail).snapshots();

  //   // final List<DocumentSnapshot<Map<String, dynamic>>> subcollectionDocuments =
  //   //     [];
  //   List<OAYSOfferProduct> offerProduct = [];

  //   parentStream.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
  //     for (final DocumentSnapshot<Map<String, dynamic>> document
  //         in snapshot.docs) {
  //       final Stream<QuerySnapshot<Map<String, dynamic>>> subcollectionStream =
  //           document.reference.collection(offerProductDetail).snapshots();

  //       subcollectionStream.listen(
  //           (QuerySnapshot<Map<String, dynamic>> subcollectionSnapshot) {
  //         for (final DocumentSnapshot<
  //                 Map<String, dynamic>> subcollectionDocument
  //             in subcollectionSnapshot.docs) {
  //           // subcollectionDocuments.add(subcollectionDocument);
  //           offerProduct.add(
  //               OAYSOfferProduct.fromDocumentSnapshot(subcollectionDocument));
  //         }
  //         // print('getOfferProductStreamByNearForUser3');
  //         // print(offerProduct.first.isOfferImageBlank);
  //       });
  //     }
  //   });
  // }

  Stream<List<OAYSOfferProduct>> getOfferNearMeForUserByStream() {
    return _db
        .collection(productDetail)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      List<OAYSOfferProduct> offerProduct = [];
      offerProduct.clear();
      for (final DocumentSnapshot<Map<String, dynamic>> document
          in snapshot.docs) {
        document.reference.collection(offerProductDetail).snapshots().listen(
            (QuerySnapshot<Map<String, dynamic>> subcollectionSnapshot) {
          for (var change in subcollectionSnapshot.docChanges) {
            print(change.type);
            switch (change.type) {
              case DocumentChangeType.added:
                if (change.doc.data()!['shopCity'] == 'Pattabiram' &&
                    isOfferActive(change.doc.data()!['offerProductEndDate'])) {
                  // print(change.doc.data()!['shopCity']);
                  offerProduct
                      .add(OAYSOfferProduct.fromDocumentSnapshot(change.doc));
                }
                break;
              case DocumentChangeType.modified:
                offerProduct.removeWhere((element) =>
                    element.offerProductId ==
                    change.doc.data()!['offerProductId']);
                if (change.doc.data()!['shopCity'] == 'Pattabiram' &&
                    isOfferActive(change.doc.data()!['offerProductEndDate'])) {
                  // for (int i = 0; i < offerProduct.length; i++) {
                  //   if (offerProduct[i].offerProductId ==
                  //       change.doc.data()!['offerProductId']) {
                  // offerProduct.removeWhere((element) =>
                  //     element.offerProductId ==
                  //     change.doc.data()!['offerProductId']);
                  //     break;
                  //   }
                  // }
                  offerProduct
                      .add(OAYSOfferProduct.fromDocumentSnapshot(change.doc));
                }
                break;
              case DocumentChangeType.removed:
                break;
            }
          }
          // for (final DocumentSnapshot<
          //         Map<String, dynamic>> subcollectionDocument
          //     in subcollectionSnapshot.docs) {
          //   DocumentSnapshot<Map<String, dynamic>> docsnap =
          //       subcollectionDocument;
          //   if (docsnap.data()!['shopCity'] == 'Pattabiram' &&
          //       isOfferActive(docsnap.data()!['offerProductEndDate'])) {
          //     // print('inside getOfferNearMeForUserByStream');
          //     print(docsnap.data()!['offerProductBrandName']);

          //     // offerProduct.add(
          //     //     OAYSOfferProduct.fromDocumentSnapshot(subcollectionDocument));
          //     // print(offerProduct);
          //   }
          //   // subcollectionDocument.data()!.clear();
          // }
          // subcollectionSnapshot.docs.clear();
        });
        // document.data()!.clear();
      }
      // snapshot.docs.clear();
      return offerProduct;
    });
  }

  // Stream<List<OAYSOfferProduct>> getAllOffersForUserByStream() {
  //   return _db
  //       .collection(productDetail)
  //       .snapshots()
  //       .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
  //     List<OAYSOfferProduct> offerProduct = [];
  //     for (final DocumentSnapshot<Map<String, dynamic>> document
  //         in snapshot.docs) {
  //       document.reference.collection(offerProductDetail).snapshots().listen(
  //           (QuerySnapshot<Map<String, dynamic>> subcollectionSnapshot) {
  //         for (final DocumentSnapshot<
  //                 Map<String, dynamic>> subcollectionDocument
  //             in subcollectionSnapshot.docs) {
  //           offerProduct.add(
  //               OAYSOfferProduct.fromDocumentSnapshot(subcollectionDocument));
  //         }
  //       });
  //     }
  //     return offerProduct;
  //   });
  // }

  Future<List<OAYSOfferProduct>> getOfferNearMeForUserByLocation(
      String location) async {
    final CollectionReference collection = _db.collection(productDetail);
    List<OAYSOfferProduct> offerProduct = [];

    for (final QueryDocumentSnapshot document
        in await collection.get().then((value) => value.docs)) {
      final CollectionReference subcollection =
          document.reference.collection(offerProductDetail);
      final QuerySnapshot<Map<String, dynamic>> subcollectionQuerySnapshot =
          await subcollection
              // .where('shopCity', isEqualTo: 'Avadi')
              .orderBy("updatedDate", descending: true)
              .get() as QuerySnapshot<Map<String, dynamic>>;
      // print(subcollectionQuerySnapshot.docs.length);
      for (final QueryDocumentSnapshot subcollectionDocument
          in subcollectionQuerySnapshot.docs) {
        DocumentSnapshot<Map<String, dynamic>> docsnap =
            subcollectionDocument as DocumentSnapshot<Map<String, dynamic>>;
        if (docsnap.data()!['shopCity'] == location &&
            isOfferActive(docsnap.data()!['offerProductEndDate'])) {
          offerProduct.add(OAYSOfferProduct.fromDocumentSnapshotWithSymbol(
              subcollectionDocument as DocumentSnapshot<Map<String, dynamic>>));
        }
      }
    }

    return offerProduct;
  }

  Future<List<OAYSOfferProduct>> getAllOffersForUserByAll() async {
    final CollectionReference collection = _db.collection(productDetail);
    List<OAYSOfferProduct> offerProduct = [];

    for (final QueryDocumentSnapshot document
        in await collection.get().then((value) => value.docs)) {
      final CollectionReference subcollection =
          document.reference.collection(offerProductDetail);
      final QuerySnapshot<Map<String, dynamic>> subcollectionQuerySnapshot =
          await subcollection.orderBy("updatedDate", descending: false).get()
              as QuerySnapshot<Map<String, dynamic>>;

      for (final QueryDocumentSnapshot subcollectionDocument
          in subcollectionQuerySnapshot.docs) {
        DocumentSnapshot<Map<String, dynamic>> docsnap =
            subcollectionDocument as DocumentSnapshot<Map<String, dynamic>>;
        if (isOfferActive(docsnap.data()!['offerProductEndDate'])) {
          offerProduct.add(OAYSOfferProduct.fromDocumentSnapshotWithSymbol(
              subcollectionDocument as DocumentSnapshot<Map<String, dynamic>>));
        }
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

  bool isOfferActive(String endDate) {
    final currentDate = DateTime.now();
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    final formattedCurrentDate =
        dateFormat.parse(dateFormat.format(currentDate));
    final offerEndDate = dateFormat.parse(endDate);
    if (offerEndDate.compareTo(formattedCurrentDate) >= 0) {
      return true;
    }
    return false;
  }
}
