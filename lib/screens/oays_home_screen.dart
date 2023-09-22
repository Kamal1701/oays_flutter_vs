import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_authentication_controller.dart';
import 'package:oaysflutter/controllers/oays_drawer_controller.dart';
import 'package:oaysflutter/controllers/oays_user_model.controller.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSHomeScreen extends StatelessWidget {
  final drawerController = Get.put(OAYSHomeScreenDrawerController());
  final userController = Get.put(OAYSUserController());
  OAYSHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            drawerController.pageTitle.value,
          ),
        ),
        backgroundColor: backgroundDarkColor,
      ),
      body: Center(
        child: Obx(
          () => Text(
            drawerController.pageTitle.value,
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 0,
        backgroundColor: boxFillColor,
        width: 250,
        child: ListView(
          children: [
            GetBuilder<OAYSUserController>(
              // initState: (_) async {
              //   print(Get.find<OAYSAuthenticationController>().user!.uid);
              //   // Get.find<OAYSUserController>().oaysUser =
              //   //     await OAYSDatabaseService().getCustomer(
              //   //         Get.find<OAYSAuthenticationController>().user!.uid);
              // },
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
          oAYSMenuOption(
            3,
            addOfferProduct,
          ),
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
      child: Obx(
        () {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            selected: drawerController.selectedIndex.value == id,
            onTap: () {
              drawerController.setSelectedMenuIndex(id);
              Get.back();
            },
          );
        },
      ),
    );
  }
}
