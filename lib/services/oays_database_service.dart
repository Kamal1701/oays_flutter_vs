import 'package:cloud_firestore/cloud_firestore.dart';
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
    // return CustomerRegistration.fromMap(
    //     snapshot.data() as Map<String, dynamic>);
  }

  // Future<DocumentSnapshot?> getCustomer() async {
  //   try {
  //     DocumentSnapshot snapshot =
  //         await _db.collection("CustomerProfile").doc(userId).get();
  //     if (snapshot.exists) {
  //       // final Map<String, dynamic> data =
  //       //     snapshot.data() as Map<String, dynamic>;
  //       return snapshot;
  //     }
  //   } catch (e) {
  //     //
  //   }
  //   return null;
  //   // return CustomerRegistration.fromMap(
  //   //     snapshot.data() as Map<String, dynamic>);
  // }
}
