import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_merchant_profile_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSMerchantProfileScreen extends StatelessWidget {
  final profileUpdateController =
      Get.put(OAYSMerchantProfileScreenController());
  OAYSMerchantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Merchant Profile',
          ),
          backgroundColor: backgroundDarkColor,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              backgroundLightColor,
              backgroundDarkColor,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                children: [
                  addVerticalSpace(10),
                  const Text(
                    'Merchant Profile',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  addVerticalSpace(30),
                  TextField(
                    enabled: false,
                    controller: profileUpdateController.merchantUserName,
                    decoration: InputDecoration(
                        // hintText: 'User Name',
                        labelText: 'User Name',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hintTextColor)),
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  addVerticalSpace(15),
                  TextField(
                    enabled: false,
                    controller: profileUpdateController.merchantEmailAddress,
                    decoration: InputDecoration(
                        // hintText: 'Email Address',
                        labelText: 'Email Address',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hintTextColor)),
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  addVerticalSpace(15),
                  TextField(
                    controller: profileUpdateController.merchantLocation,
                    decoration: InputDecoration(
                        hintText: 'User Location',
                        labelText: 'User Location',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hintTextColor)),
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  addVerticalSpace(15),
                  TextField(
                    controller: profileUpdateController.merchantShopName,
                    decoration: InputDecoration(
                        hintText: 'Shop Name',
                        labelText: 'Shop Name',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hintTextColor)),
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  addVerticalSpace(15),
                  TextField(
                    controller: profileUpdateController.merchantShopStreet,
                    decoration: InputDecoration(
                        hintText: 'Shop Street',
                        labelText: 'Shop Street',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hintTextColor)),
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  addVerticalSpace(15),
                  TextField(
                    controller: profileUpdateController.merchantShopCity,
                    decoration: InputDecoration(
                        hintText: 'Shop City',
                        labelText: 'Shop City',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hintTextColor)),
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  addVerticalSpace(15),
                  TextField(
                    controller: profileUpdateController.merchantShopState,
                    decoration: InputDecoration(
                        hintText: 'Shop State',
                        labelText: 'Shop State',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hintTextColor)),
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  addVerticalSpace(15),
                  TextField(
                    controller: profileUpdateController.merchantShopPincode,
                    decoration: InputDecoration(
                        hintText: 'Shop Pincode',
                        labelText: 'Shop Pincode',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hintTextColor)),
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  addVerticalSpace(15),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 15, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              profileUpdateController.updateMerchantProfile();
                            },
                            child: const Text("Update"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 30, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              profileUpdateController.cancelUpdateProfile();
                            },
                            child: const Text("Cancel"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
