import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/components/oays_signin_button.dart';
import 'package:oaysflutter/components/oays_textfield.dart';
import 'package:oaysflutter/controllers/oays_signin_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSSignInScreen extends GetView<OAYSSignInScreenController> {
  final signInController =
      Get.put<OAYSSignInScreenController>(OAYSSignInScreenController());
  OAYSSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                backgroundLightColor,
                backgroundDarkColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    children: [
                      addVerticalSpace(200),
                      OAYSCustomTextField(
                          controller: signInController.emailAddress,
                          labelText: 'Email id',
                          obscureText: false),
                      addVerticalSpace(15),
                      OAYSCustomTextField(
                          controller: signInController.password,
                          labelText: 'Password',
                          obscureText: true),
                      addVerticalSpace(5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: oaysFontColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      addVerticalSpace(15),
                      OAYSSignInButton(
                          buttonText: 'Sign In',
                          onTap: () async {
                            signInController.oaysUserSignin();
                          }),
                      addVerticalSpace(15),
                      signUpOption(),
                      addVerticalSpace(200),
                      signUpAsMerchantOption(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: signInController.isLoginSuccess.value,
            child: const Opacity(
              opacity: 0.5,
              child: ModalBarrier(
                dismissible: false,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: signInController.isLoginSuccess.value,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Don't have account? ",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () => signInController.oaysCustomerSignUp(),
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Row signUpAsMerchantOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Want to catch more customers? ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                // fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                signInController.oaysMerchantSignUp();
              },
              child: const Text(
                "Sign Up As Merchant",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
