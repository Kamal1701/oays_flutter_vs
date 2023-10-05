import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/controllers/oays_customer_profile_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSCustomerProfileScreen extends StatelessWidget {
  final profileUpdateController =
      Get.put(OAYSCustomerProfileScreenController());

  OAYSCustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: const Text(
        //       profile,
        //     ),
        //     backgroundColor: backgroundDarkColor,
        //   ),
        //   body:
        Container(
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
                'Customer Profile',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              addVerticalSpace(30),
              // OAYSCustomTextField(
              //   controller: profileUpdateController.custUserName,
              //   labelText: 'User Name',
              //   obscureText: false,
              // ),
              TextField(
                enabled: false,
                controller: profileUpdateController.custUserName,
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
              // OAYSCustomTextField(
              //   controller: profileUpdateController.custEmailAddress,
              //   labelText: 'Email Address',
              //   obscureText: false,
              // ),
              TextField(
                enabled: false,
                controller: profileUpdateController.custEmailAddress,
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
              // OAYSCustomTextField(
              //   controller: profileUpdateController.custPassword,
              //   labelText: 'Password',
              //   obscureText: true,
              // ),
              // addVerticalSpace(15),
              // OAYSCustomTextField(
              //     controller: profileUpdateController.custLocation,
              //     labelText: 'User Location',
              //     obscureText: false),
              TextField(
                controller: profileUpdateController.custLocation,
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 15, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          // addController.addProduct();
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
                          // addController.cancelProduct();
                        },
                        child: const Text("Cancel"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // ),
      // drawer: OAYSNavigationDrawer(),
    );
  }
}
