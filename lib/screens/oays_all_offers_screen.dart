import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_offer_near_me_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';
import 'package:oaysflutter/utils/helpers/drawer_widget.dart';

class OAYSAllOffersScreen extends StatelessWidget {
  final productController = Get.put(OAYSOfferNearMeScreenController());
  OAYSAllOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          allOffers,
        ),
        backgroundColor: backgroundDarkColor,
      ),
      drawer: OAYSNavigationDrawer(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0),
        decoration: BoxDecoration(
          color: backgroundDarkColor,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            // childAspectRatio: 1.5,
            mainAxisExtent: 275,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7,
          ),
          itemCount: productController.offerProductList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                productController.goToOAYSOfferProductDetailScreen(
                    productController.offerProductList[index]);
              },
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: boxFillColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 5, 4, 0),
                    child: productController
                            .offerProductList[index].isOfferImageBlank
                        ? Image.asset(
                            'assets/images/camera.png',
                            height: 180,
                            width: 180,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            productController
                                .offerProductList[index].offerImageUrl,
                            height: 180,
                            width: 180,
                            fit: BoxFit.fill,
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                          child: Text(
                            productController
                                .offerProductList[index].offerProductName,
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
                          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0, 0),
                          child: Text(
                            productController.offerProductList[index]
                                .offerProductActualPrice,
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 3,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0, 0),
                          child: Text(
                              productController.offerProductList[index]
                                  .offerProductDiscountPrice,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: oaysFontColor,
                              )),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0, 0),
                          child: Text(
                              productController.offerProductList[index]
                                  .offerProductDiscountPerc,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
                      const Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 0, 0),
                          child: Text(
                            "Last Date ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0, 0),
                          child: Text(
                              productController
                                  .offerProductList[index].offerProductEndDate,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: oaysFontColor,
                              )),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
