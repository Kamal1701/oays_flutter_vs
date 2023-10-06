import 'package:flutter/material.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';

Widget viewOfferContainer(OAYSOfferProduct offerProduct) {
  return Container(
    alignment: Alignment.topLeft,
    decoration: BoxDecoration(
      color: Colors.grey.shade100.withOpacity(0.5),
      border: Border.all(color: backgroundDarkColor),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(4, 6, 4, 0),
        child: offerProduct.isOfferImageBlank
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/camera.png',
                  height: 180,
                  width: 180,
                  fit: BoxFit.fill,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  offerProduct.offerImageUrl,
                  height: 180,
                  width: 180,
                  fit: BoxFit.fill,
                ),
              ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 5.0, 0, 0),
              child: Text(
                offerProduct.offerProductName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: oaysFontColor,
                ),
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0, 0),
              child: Text(
                offerProduct.offerProductActualPrice,
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.red,
                  decorationThickness: 3,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0, 0),
              child: Text(offerProduct.offerProductDiscountPrice,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: oaysFontColor,
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0, 0),
              child: Text(offerProduct.offerProductDiscountPerc,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: oaysFontColor,
                  )),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 2.0, 0, 0),
              child: Text(
                "Last Date ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: oaysFontColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 3.0, 4.0, 0),
              child: Text(offerProduct.offerProductEndDate,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: oaysFontColor,
                  )),
            ),
          ),
        ],
      ),
    ]),
  );
}
