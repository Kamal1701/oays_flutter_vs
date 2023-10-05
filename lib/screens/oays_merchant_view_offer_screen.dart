import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_merchant_view_offer_screen_controller.dart';
import 'package:oaysflutter/controllers/oays_offer_product_model_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSMerchantViewOfferScreen extends StatelessWidget {
  final productController = Get.put(OAYSOfferProductController());
  final viewOfferController = Get.put(OAYSMerchantViewOfferScreenController());

  OAYSMerchantViewOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => productController.isLoading.value
          ? progressIndicator()
          : Stack(
              children: [
                productController.offerProductList.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
                        decoration: BoxDecoration(
                          color: boxFillColor,
                        ),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            // childAspectRatio: 2.35,
                            mainAxisExtent: 178,
                          ),
                          itemCount: productController.offerProductList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SizedBox(
                                child: InkWell(
                                  onTap: () {
                                    viewOfferController
                                        .goToOAYSMerchantEditOfferPage(
                                            productController
                                                .offerProductList[index]);
                                  },
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100
                                            .withOpacity(0.5),
                                        border: Border.all(
                                            color: backgroundDarkColor),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(3, 3, 3, 3),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 5, 10, 5),
                                                child: SizedBox(
                                                  height: 150,
                                                  width: 150,
                                                  // color: Colors.red,
                                                  child: productController
                                                              .offerProductList[
                                                                  index]
                                                              .isOfferImageBlank ==
                                                          true
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: Image.asset(
                                                            'assets/images/camera.png',
                                                            height: 180,
                                                            width: 180,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        )
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: Image.network(
                                                            productController
                                                                .offerProductList[
                                                                    index]
                                                                .offerImageUrl,
                                                            height: 180,
                                                            width: 180,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  addVerticalSpace(10),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        productController
                                                            .offerProductList[
                                                                index]
                                                            .offerProductName,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  addVerticalSpace(5),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        productController
                                                            .offerProductList[
                                                                index]
                                                            .offerProductBrandName,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  addVerticalSpace(5),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        productController
                                                            .offerProductList[
                                                                index]
                                                            .offerProductActualPrice,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationThickness:
                                                              3,
                                                          decorationColor:
                                                              Colors.red,
                                                        ),
                                                      ),
                                                      addHorizontalSpace(30),
                                                      Text(
                                                        productController
                                                            .offerProductList[
                                                                index]
                                                            .offerProductDiscountPrice,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      addHorizontalSpace(30),
                                                      Text(
                                                        productController
                                                            .offerProductList[
                                                                index]
                                                            .offerProductDiscountPerc,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  addVerticalSpace(5),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Start Date",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      addHorizontalSpace(20),
                                                      Text(
                                                        productController
                                                            .offerProductList[
                                                                index]
                                                            .offerProductStartDate,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  addVerticalSpace(5),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "End Date",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      addHorizontalSpace(26),
                                                      Text(
                                                        productController
                                                            .offerProductList[
                                                                index]
                                                            .offerProductEndDate,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: backgroundLightColor,
                        ),
                        child: Center(
                          child: Text(
                            "No products to view...",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: oaysFontColor,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
    );
  }
}
