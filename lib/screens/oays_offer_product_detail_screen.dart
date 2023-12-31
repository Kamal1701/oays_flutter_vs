import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_offer_product_detail_screen_controller.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSOfferProductDetailScreen extends StatelessWidget {
  final productDetailController = Get.put(
      OAYSOfferProductDetailScreenController(
          Get.arguments as OAYSOfferProduct));
  final userController = Get.find<OAYSUserController>();
  OAYSOfferProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Offer Details"),
          backgroundColor: backgroundDarkColor,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [backgroundLightColor, backgroundLightColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: SizedBox(
                              height: 200,
                              width: 180,
                              // color: Colors.red,
                              child: productDetailController
                                      .oaysOfferProduct.isOfferImageBlank
                                  ? Image.asset(
                                      'assets/images/camera.png',
                                      height: 225,
                                      width: 200,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      productDetailController
                                          .oaysOfferProduct.offerImageUrl,
                                      height: 225,
                                      width: 200,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addVerticalSpace(10),
                              Row(
                                children: [
                                  Text(
                                    productDetailController
                                        .oaysOfferProduct.offerProductName,
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: oaysFontColor,
                                    ),
                                  ),
                                ],
                              ),
                              addVerticalSpace(10),
                              Row(
                                children: [
                                  Text(
                                    productDetailController
                                        .oaysOfferProduct.offerProductBrandName,
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: oaysFontColor,
                                    ),
                                  ),
                                ],
                              ),
                              addVerticalSpace(10),
                              Row(
                                children: [
                                  Text(
                                    productDetailController.oaysOfferProduct
                                        .offerProductActualPrice,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: oaysFontColor,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 3,
                                      decorationColor: Colors.red,
                                    ),
                                  ),
                                  addHorizontalSpace(15),
                                  Text(
                                    productDetailController.oaysOfferProduct
                                        .offerProductDiscountPrice,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: oaysFontColor,
                                    ),
                                  ),
                                  addHorizontalSpace(15),
                                  Text(
                                    productDetailController.oaysOfferProduct
                                        .offerProductDiscountPerc,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: oaysFontColor,
                                    ),
                                  ),
                                ],
                              ),
                              addVerticalSpace(10),
                              Row(
                                children: [
                                  Text(
                                    productDetailController
                                        .oaysOfferProduct.offerProductWeigh,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: oaysFontColor,
                                    ),
                                  ),
                                ],
                              ),
                              addVerticalSpace(10),
                              Row(
                                children: [
                                  const Text(
                                    "Start Date",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  addHorizontalSpace(26),
                                  Text(
                                    productDetailController
                                        .oaysOfferProduct.offerProductStartDate,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: oaysFontColor,
                                    ),
                                  ),
                                ],
                              ),
                              addVerticalSpace(10),
                              Row(
                                children: [
                                  const Text(
                                    "End Date",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  addHorizontalSpace(32),
                                  Text(
                                    productDetailController
                                        .oaysOfferProduct.offerProductEndDate,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: oaysFontColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      addVerticalSpace(25),
                      const Text(
                        "Shop Details: ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      addVerticalSpace(10),
                      Text(
                        // userController.oaysUser.shopName,
                        productDetailController.oaysOfferProduct.shopName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: oaysFontColor,
                        ),
                      ),
                      addVerticalSpace(10),
                      Text(
                        // userController.oaysUser.shopStreetName,
                        productDetailController.oaysOfferProduct.shopStreetName,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: oaysFontColor),
                      ),
                      addVerticalSpace(10),
                      Text(
                        // userController.oaysUser.shopCity,
                        productDetailController.oaysOfferProduct.shopCity,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: oaysFontColor,
                        ),
                      ),
                      addVerticalSpace(10),
                      Text(
                        // userController.oaysUser.shopState,
                        productDetailController.oaysOfferProduct.shopState,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: oaysFontColor,
                        ),
                      ),
                      addVerticalSpace(10),
                      Text(
                        // userController.oaysUser.shopPincode,
                        productDetailController.oaysOfferProduct.shopPincode,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: oaysFontColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
