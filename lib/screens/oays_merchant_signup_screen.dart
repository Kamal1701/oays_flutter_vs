import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/components/oays_signin_button.dart';
import 'package:oaysflutter/components/oays_textfield.dart';
import 'package:oaysflutter/controllers/oays_merchant_signup_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSMerchantSignUpScreen extends StatelessWidget {
  final signUpController = Get.put(OAYSMerchantSignUpController());
  OAYSMerchantSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                  child: Column(
                    children: [
                      addVerticalSpace(30),
                      const Text(
                        'Merchant Registration',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      addVerticalSpace(30),
                      OAYSCustomTextField(
                        controller: signUpController.merchantUserName,
                        labelText: 'User Name',
                        obscureText: false,
                      ),
                      addVerticalSpace(15),
                      OAYSCustomTextField(
                        controller: signUpController.merchantEmailAddress,
                        labelText: 'Email Address',
                        obscureText: false,
                      ),
                      addVerticalSpace(15),
                      OAYSCustomTextField(
                        controller: signUpController.merchantPassword,
                        labelText: 'Password',
                        obscureText: true,
                      ),
                      addVerticalSpace(15),
                      OAYSCustomTextField(
                          controller: signUpController.merchantLocation,
                          labelText: 'User Location',
                          obscureText: false),
                      addVerticalSpace(15),
                      OAYSCustomTextField(
                        controller: signUpController.merchantShopName,
                        labelText: 'Shop Name',
                        obscureText: false,
                      ),
                      addVerticalSpace(15),
                      OAYSCustomTextField(
                        controller: signUpController.merchantShopStreet,
                        labelText: 'Shop Street',
                        obscureText: false,
                      ),
                      addVerticalSpace(15),
                      OAYSCustomTextField(
                        controller: signUpController.merchantShopCity,
                        labelText: 'Shop City',
                        obscureText: true,
                      ),
                      addVerticalSpace(15),
                      OAYSCustomTextField(
                          controller: signUpController.merchantShopState,
                          labelText: 'Shop State',
                          obscureText: false),
                      addVerticalSpace(15),
                      OAYSCustomTextField(
                          controller: signUpController.merchantShopPincode,
                          labelText: 'Shop Pincode',
                          obscureText: false),
                      addVerticalSpace(15),
                      OAYSSignInButton(
                        buttonText: 'Register',
                        onTap: () {
                          signUpController.createMerchantProfile();
                        },
                      ),
                      addVerticalSpace(50),
                    ],
                  ),
                ),
              )),
        ),
        Obx(
          () => signUpController.isRegisterSuccess.value
              ? const Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: ModalBarrier(
                        color: Colors.black,
                        dismissible: false,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ),
      ],
    );
  }
}
