import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_drawer_controller.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/global_variable.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSHomeScreen extends StatelessWidget {
  final userController = Get.put(OAYSUserController());
  final drawerController = Get.put(OAYSHomeScreenDrawerController());

  OAYSHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          // Show a dialog to confirm with the user
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: backgroundLightColor,
              title: Text(
                'OAYS Info',
                style: TextStyle(
                  color: oaysFontColor,
                ),
              ),
              content: Text(
                'Do you want to exit now?',
                style: TextStyle(
                  color: oaysFontColor,
                  fontSize: 18,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: oaysFontColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: Text(
                    'Yes',
                    style: TextStyle(color: oaysFontColor),
                  ),
                ),
              ],
            ),
          );
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(drawerController.getAppBarTitle()),
              backgroundColor: backgroundDarkColor,
              actions: [
                popUpOAYSMenuItem(),
              ],
            ),
            drawer: SizedBox(
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
                                    userController.oaysUser.userName,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Obx(
                                    () => Text(
                                      userController.oaysUser.userLocation,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                    ),
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
            ),
            body: drawerController
                .setSelectedMenuIndex(drawerController.selectedIndex.value),
          ),
        ),
      ),
    );
  }

  Widget popUpOAYSMenuItem() {
    return PopupMenuButton(
      onSelected: (value) {
        drawerController.onPopupMenuItemSelection(
            value, userController.oaysUser.isMerchant);
      },
      offset: Offset(0.0, AppBar().preferredSize.height),
      itemBuilder: (context) => [
        PopupMenuItem(
            value: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                addHorizontalSpace(10.0),
                Text(
                  'Profile',
                  style: TextStyle(color: oaysFontColor),
                ),
              ],
            )),
        PopupMenuItem(
            value: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.logout, color: Colors.black),
                addHorizontalSpace(10.0),
                Text(
                  'Logout',
                  style: TextStyle(color: oaysFontColor),
                ),
              ],
            )),
      ],
    );
  }

  Widget oAYSDrawerList() {
    return Obx(
      () => Container(
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
            if (userController.oaysUser.isMerchant)
              oAYSMenuOption(
                2,
                addOfferProduct,
              ),
            if (userController.oaysUser.isMerchant)
              oAYSMenuOption(
                3,
                updateOffer,
              ),
          ],
        ),
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
              navigateToScreenIndex = id;
              drawerController.onSelectedItem(id);
            },
          );
        },
      ),
    );
  }
}
