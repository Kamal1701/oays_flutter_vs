import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_offer_near_me_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/customer_offer_view_widget.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSOfferNearMeScreen extends StatelessWidget {
  final productController = Get.put(OAYSOfferNearMeScreenController());
  OAYSOfferNearMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => productController.isLoading.value
          ? progressIndicator()
          : Stack(
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
                                        .offerProductList[index]));
                              },
                            );
                          },
                        ),
                      )
                    : noProductTextWidget()
              ],
            ),
    );
  }
}
