import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_drawer_controller.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSNavigationDrawer extends StatelessWidget {
  final drawerController = Get.put(OAYSHomeScreenDrawerController());
  final userController = Get.put(OAYSUserController());
  OAYSNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        elevation: 0,
        backgroundColor: boxFillColor,
        width: 250,
        child: ListView(
          children: [
            GetBuilder<OAYSUserController>(
              builder: (controller) {
                return DrawerHeader(
                  decoration: BoxDecoration(
                    color: backgroundDarkColor,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            controller.oaysUser.userName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            controller.oaysUser.userLocation,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            oAYSDrawerList(),
          ],
        ),
      ),
    );
  }

  Widget oAYSDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      color: backgroundDarkColor,
      child: Column(
        children: [
          oAYSMenuOption(
            0,
            offerNearMe,
          ),
          oAYSMenuOption(
            1,
            allOffers,
          ),
          oAYSMenuOption(
            2,
            profile,
          ),
          if (userController.oaysUser.isMerchant)
            oAYSMenuOption(
              3,
              addOfferProduct,
            ),
          if (userController.oaysUser.isMerchant)
            oAYSMenuOption(
              4,
              updateOffer,
            ),
        ],
      ),
    );
  }

  Widget oAYSMenuOption(int id, String title) {
    return Material(
      color: boxFillColor,
      child:
          // Obx(
          //   () {
          //     return
          ListTile(
        leading: const Icon(Icons.person),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        selected: navigateToScreenIndex == id,
        onTap: () {
          drawerController.setSelectedMenuIndex(id);
        },
        // );
        // },
      ),
    );
  }
}
