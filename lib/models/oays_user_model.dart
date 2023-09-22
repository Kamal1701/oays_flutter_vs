import 'package:cloud_firestore/cloud_firestore.dart';

class OAYSUser {
  String userId;
  String userName;
  String userLocation;
  bool isMerchant;
  String shopName;
  String shopStreetName;
  String shopCity;
  String shopState;
  String shopPincode;

  OAYSUser(
    this.userId,
    this.userName,
    this.userLocation,
    this.isMerchant,
    this.shopName,
    this.shopStreetName,
    this.shopCity,
    this.shopState,
    this.shopPincode,
  );

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userLocation': userLocation,
      'isMerchant': isMerchant,
      'shopName': shopName,
      'shopStreetName': shopStreetName,
      'shopCity': shopCity,
      'shopState': shopState,
      'shopPincode': shopPincode,
    };
  }

  OAYSUser.fromDocumentSnapShot(DocumentSnapshot<Map<String, dynamic>> docSnap)
      : userId = docSnap.data()!['userId'],
        userName = docSnap.data()!['userName'],
        userLocation = docSnap.data()!['userLocation'],
        isMerchant = docSnap.data()!['isMerchant'],
        shopName = docSnap.data()!['shopName'],
        shopStreetName = docSnap.data()!['shopStreetName'],
        shopCity = docSnap.data()!['shopCity'],
        shopState = docSnap.data()!['shopState'],
        shopPincode = docSnap.data()!['shopPincode'];

  factory OAYSUser.fromMap(Map<String, dynamic> data) {
    return OAYSUser(
      data['userId'],
      data['userName'],
      data['userLocation'],
      data['isMerchant'],
      data['shopName'],
      data['shopStreetName'],
      data['shopCity'],
      data['shopState'],
      data['shopPincode'],
    );
  }
}
