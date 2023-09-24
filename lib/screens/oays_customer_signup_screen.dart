import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/components/oays_signin_button.dart';
import 'package:oaysflutter/components/oays_textfield.dart';
import 'package:oaysflutter/controllers/oays_customer_signup_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSCustomerSignUpScreen extends StatelessWidget {
  final signUpController = Get.put(OAYSCustomerSignUpController());
  OAYSCustomerSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => signUpController.isRegisterSuccess.value
          ? progressIndicator()
          : Stack(
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
                          end: Alignment.bottomCenter),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                        child: Column(
                          children: [
                            addVerticalSpace(30),
                            const Text(
                              'Customer Registration',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            addVerticalSpace(30),
                            OAYSCustomTextField(
                              controller: signUpController.custUserName,
                              labelText: 'User Name',
                              obscureText: false,
                            ),
                            addVerticalSpace(15),
                            OAYSCustomTextField(
                              controller: signUpController.custEmailAddress,
                              labelText: 'Email Address',
                              obscureText: false,
                            ),
                            addVerticalSpace(15),
                            OAYSCustomTextField(
                              controller: signUpController.custPassword,
                              labelText: 'Password',
                              obscureText: true,
                            ),
                            addVerticalSpace(15),
                            OAYSCustomTextField(
                                controller: signUpController.custLocation,
                                labelText: 'User Location',
                                obscureText: false),
                            addVerticalSpace(15),
                            OAYSSignInButton(
                                buttonText: 'Register',
                                onTap: () {
                                  signUpController.createCustomerProfile();
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
