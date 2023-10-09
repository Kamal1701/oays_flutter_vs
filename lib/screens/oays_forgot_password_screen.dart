import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oaysflutter/components/oays_textfield.dart';
import 'package:oaysflutter/controllers/oays_forgot_password_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSForgotPasswordScreen extends StatelessWidget {
  final resetController = Get.put(OAYSForgotPasswordScreenController());
  OAYSForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    children: [
                      addVerticalSpace(50),
                      const Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      addVerticalSpace(10),
                      OAYSCustomTextField(
                          controller: resetController.emailAddress,
                          labelText: 'Email id',
                          obscureText: false),
                      addVerticalSpace(15),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 15, 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  // resetController.addProduct();
                                },
                                child: const Text("Reset"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 30, 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  resetController.backToSignInScreen();
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
            ),
          ),
        ),
      ],
    );
  }
}
