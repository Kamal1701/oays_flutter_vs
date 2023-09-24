import 'package:cloud_firestore/cloud_firestore.dart';

class OAYSOfferProduct {
  String offerProductId;
  String offerImageUrl;
  bool isOfferImageBlank;
  String offerProductName;
  String offerProductBrandName;
  String offerProductCategory;
  String offerProductSubcategory;
  String offerProductActualPrice;
  String offerProductDiscountPrice;
  String offerProductStartDate;
  String offerProductEndDate;
  String offerProductWeigh;
  String offerProductDiscountPerc;
  String offerProductDescription;
  String shopName;
  String shopStreetName;
  String shopCity;
  String shopState;
  String shopPincode;

  OAYSOfferProduct(
    this.offerProductId,
    this.offerImageUrl,
    this.isOfferImageBlank,
    this.offerProductName,
    this.offerProductBrandName,
    this.offerProductCategory,
    this.offerProductSubcategory,
    this.offerProductActualPrice,
    this.offerProductDiscountPrice,
    this.offerProductStartDate,
    this.offerProductEndDate,
    this.offerProductWeigh,
    this.offerProductDiscountPerc,
    this.offerProductDescription,
    this.shopName,
    this.shopStreetName,
    this.shopCity,
    this.shopState,
    this.shopPincode,
  );

  Map<String, dynamic> toMap() {
    return {
      'offerProductId': offerProductId,
      'offerImageUrl': offerImageUrl,
      'isOfferImageBlank': isOfferImageBlank,
      'offerProductName': offerProductName,
      'offerProductBrandName': offerProductBrandName,
      'offerProductCategory': offerProductCategory,
      'offerProductSubcategory': offerProductSubcategory,
      'offerProductActualPrice': offerProductActualPrice,
      'offerProductDiscountPrice': offerProductDiscountPrice,
      'offerProductStartDate': offerProductStartDate,
      'offerProductEndDate': offerProductEndDate,
      'offerProductWeigh': offerProductWeigh,
      'offerProductDiscountPerc': offerProductDiscountPerc,
      'offerProductDescription': offerProductDescription,
      'shopName': shopName,
      'shopStreetName': shopStreetName,
      'shopCity': shopCity,
      'shopState': shopState,
      'shopPincode': shopPincode,
    };
  }

  factory OAYSOfferProduct.fromMap(Map<String, dynamic> data) {
    return OAYSOfferProduct(
      data['offerProductId'],
      data['offerImageUrl'],
      data['isOfferImageBlank'],
      data['offerProductName'],
      data['offerProductBrandName'],
      data['offerProductCategory'],
      data['offerProductSubcategory'],
      data['offerProductActualPrice'],
      data['offerProductDiscountPrice'],
      data['offerProductStartDate'],
      data['offerProductEndDate'],
      data['offerProductWeigh'],
      data['offerProductDiscountPerc'],
      data['offerProductDescription'],
      data['shopName'],
      data['shopStreetName'],
      data['shopCity'],
      data['shopState'],
      data['shopPincode'],
    );
  }

  OAYSOfferProduct.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> docSnap)
      : offerProductId = docSnap.data()!['offerProductId'],
        offerImageUrl = docSnap.data()!['offerImageUrl'],
        isOfferImageBlank = docSnap.data()!['isOfferImageBlank'],
        offerProductName = docSnap.data()!['offerProductName'],
        offerProductBrandName = docSnap.data()!['offerProductBrandName'],
        offerProductCategory = docSnap.data()!['offerProductCategory'],
        offerProductSubcategory = docSnap.data()!['offerProductSubcategory'],
        offerProductActualPrice = docSnap.data()!['offerProductActualPrice'],
        offerProductDiscountPrice =
            docSnap.data()!['offerProductDiscountPrice'],
        offerProductStartDate = docSnap.data()!['offerProductStartDate'],
        offerProductEndDate = docSnap.data()!['offerProductEndDate'],
        offerProductWeigh = docSnap.data()!['offerProductWeigh'],
        offerProductDiscountPerc = docSnap.data()!['offerProductDiscountPerc'],
        offerProductDescription = docSnap.data()!['offerProductDescription'],
        shopName = docSnap.data()!['shopName'],
        shopStreetName = docSnap.data()!['shopStreetName'],
        shopCity = docSnap.data()!['shopCity'],
        shopState = docSnap.data()!['shopState'],
        shopPincode = docSnap.data()!['shopPincode'];

  factory OAYSOfferProduct.fromSnapshot(DocumentSnapshot docSnap) {
    return OAYSOfferProduct(
        docSnap.id,
        docSnap['offerImageUrl'],
        docSnap['isOfferImageBlank'],
        docSnap['offerProductName'],
        docSnap['offerProductBrandName'],
        docSnap['offerProductCategory'],
        docSnap['offerProductSubcategory'],
        docSnap['offerProductActualPrice'],
        docSnap['offerProductDiscountPrice'],
        docSnap['offerProductStartDate'],
        docSnap['offerProductEndDate'],
        docSnap['offerProductWeigh'],
        docSnap['offerProductDiscountPerc'],
        docSnap['offerProductDescription'],
        docSnap['shopName'],
        docSnap['shopStreetName'],
        docSnap['shopCity'],
        docSnap['shopState'],
        docSnap['shopPincode']);
  }
}
