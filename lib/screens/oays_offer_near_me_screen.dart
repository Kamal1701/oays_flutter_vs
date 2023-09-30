import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_offer_near_me_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/customer_offer_view_widget.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSOfferNearMeScreen extends StatelessWidget {
  final productController = Get.put(OAYSOfferNearMeScreenController());
  // final productController = Get.find<OAYSOfferNearMeScreenController>();
  OAYSOfferNearMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => productController.isLoading.value
          ? progressIndicator()
          :
          // Scaffold(
          //     appBar: AppBar(
          //       title: const Text(
          //         offerNearMe,
          //       ),
          //       backgroundColor: backgroundDarkColor,
          //     ),
          //     drawer: OAYSNavigationDrawer(),
          //     body:
          Stack(
              children: [
                productController.offerProductList.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0),
                        decoration: BoxDecoration(
                          color: boxFillColor,
                        ),
                        child: GetX<OAYSOfferNearMeScreenController>(
                          builder: (controller) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                // childAspectRatio: 1.5,
                                mainAxisExtent: 270,
                                crossAxisSpacing: 7,
                                mainAxisSpacing: 7,
                              ),
                              itemCount:
                                  productController.offerProductList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      productController
                                          .goToOAYSOfferProductDetailScreen(
                                              productController
                                                  .offerProductList[index]);
                                    },
                                    child: viewOfferContainer(productController
                                        .offerProductList[index])
                                    // Container(
                                    //   alignment: Alignment.topLeft,
                                    //   decoration: BoxDecoration(
                                    //     color:
                                    //         Colors.grey.shade100.withOpacity(0.5),
                                    //     border: Border.all(
                                    //         color: backgroundDarkColor),
                                    //     borderRadius: BorderRadius.circular(12),
                                    //   ),
                                    //   child: Column(children: [
                                    //     Padding(
                                    //       padding: const EdgeInsets.fromLTRB(
                                    //           4, 6, 4, 0),
                                    //       child: productController
                                    //               .offerProductList[index]
                                    //               .isOfferImageBlank
                                    //           ? ClipRRect(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(12),
                                    //               child: Image.asset(
                                    //                 'assets/images/camera.png',
                                    //                 height: 180,
                                    //                 width: 180,
                                    //                 fit: BoxFit.fill,
                                    //               ),
                                    //             )
                                    //           : ClipRRect(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(12),
                                    //               child: Image.network(
                                    //                 productController
                                    //                     .offerProductList[index]
                                    //                     .offerImageUrl,
                                    //                 height: 180,
                                    //                 width: 180,
                                    //                 fit: BoxFit.fill,
                                    //               ),
                                    //             ),
                                    //     ),
                                    //     Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.start,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Expanded(
                                    //           flex: 3,
                                    //           child: Padding(
                                    //             padding:
                                    //                 const EdgeInsets.fromLTRB(
                                    //                     8.0, 5.0, 0, 0),
                                    //             child: Text(
                                    //               productController
                                    //                   .offerProductList[index]
                                    //                   .offerProductName,
                                    //               style: TextStyle(
                                    //                 fontSize: 16,
                                    //                 fontWeight: FontWeight.bold,
                                    //                 color: oaysFontColor,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.start,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Expanded(
                                    //           flex: 1,
                                    //           child: Padding(
                                    //             padding:
                                    //                 const EdgeInsets.fromLTRB(
                                    //                     8.0, 0.0, 0, 0),
                                    //             child: Text(
                                    //               productController
                                    //                   .offerProductList[index]
                                    //                   .offerProductActualPrice,
                                    //               style: const TextStyle(
                                    //                 decoration: TextDecoration
                                    //                     .lineThrough,
                                    //                 decorationColor: Colors.red,
                                    //                 decorationThickness: 3,
                                    //                 fontSize: 15,
                                    //                 fontWeight: FontWeight.normal,
                                    //                 color: Colors.black54,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         Expanded(
                                    //           child: Padding(
                                    //             padding:
                                    //                 const EdgeInsets.fromLTRB(
                                    //                     5.0, 0.0, 0, 0),
                                    //             child: Text(
                                    //                 productController
                                    //                     .offerProductList[index]
                                    //                     .offerProductDiscountPrice,
                                    //                 style: TextStyle(
                                    //                   fontSize: 15,
                                    //                   fontWeight:
                                    //                       FontWeight.normal,
                                    //                   color: oaysFontColor,
                                    //                 )),
                                    //           ),
                                    //         ),
                                    //         Expanded(
                                    //           child: Padding(
                                    //             padding:
                                    //                 const EdgeInsets.fromLTRB(
                                    //                     5.0, 0.0, 0, 0),
                                    //             child: Text(
                                    //                 productController
                                    //                     .offerProductList[index]
                                    //                     .offerProductDiscountPerc,
                                    //                 style: TextStyle(
                                    //                   fontSize: 15,
                                    //                   fontWeight:
                                    //                       FontWeight.normal,
                                    //                   color: oaysFontColor,
                                    //                 )),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.start,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         const Expanded(
                                    //           flex: 0,
                                    //           child: Padding(
                                    //             padding: EdgeInsets.fromLTRB(
                                    //                 8.0, 2.0, 0, 0),
                                    //             child: Text(
                                    //               "Last Date ",
                                    //               style: TextStyle(
                                    //                 fontSize: 15,
                                    //                 fontWeight: FontWeight.normal,
                                    //                 color: Colors.black,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         Expanded(
                                    //           child: Padding(
                                    //             padding:
                                    //                 const EdgeInsets.fromLTRB(
                                    //                     10.0, 3.0, 4.0, 0),
                                    //             child: Text(
                                    //                 productController
                                    //                     .offerProductList[index]
                                    //                     .offerProductEndDate,
                                    //                 style: TextStyle(
                                    //                   fontSize: 15,
                                    //                   fontWeight:
                                    //                       FontWeight.normal,
                                    //                   color: oaysFontColor,
                                    //                 )),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ]),
                                    // ),
                                    );
                              },
                            );
                          },
                        ),
                      )
                    : noProductTextWidget()
                // Container(
                //     // padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0),
                //     decoration: BoxDecoration(
                //       color: backgroundLightColor,
                //     ),
                //     child: Center(
                //       child: Text(
                //         "No products to view...",
                //         style: TextStyle(
                //           fontSize: 21,
                //           fontWeight: FontWeight.bold,
                //           color: oaysFontColor,
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ),
      // ),
    );
  }
}
