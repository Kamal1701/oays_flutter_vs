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
}
