import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:oaysflutter/components/oays_textfield.dart';
import 'package:oaysflutter/controllers/oays_offer_add_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSOfferAddScreen extends StatelessWidget {
  final addController = Get.put(OAYSOfferAddScreenController());
  OAYSOfferAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [backgroundLightColor, backgroundLightColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  addVerticalSpace(20),
                  GestureDetector(
                    // onTap: !addController.isGestureTapDisabled.value
                    //     ? (() => Get.snackbar(
                    //           'Info',
                    //           'To add image, please uncheck no product image.',
                    //           snackPosition: SnackPosition.BOTTOM,
                    //           colorText: Colors.black,
                    //           backgroundColor: boxFillColor,
                    //         ))
                    //     : () async {
                    //         addController.productImagePath.value =
                    //             await _selectImageFromGallery();
                    //         if (addController.productImagePath.value != '') {
                    //           // setState(() {
                    //           //   if (controller.isNoProductImageChecked.value) {
                    //           //     controller.isGestureTapDisabled.value = true;
                    //           //   }
                    //           // });
                    //         }
                    //       },
                    onTap: () => addController.pickProductImageFromGallery(),
                    child: Obx(
                      () => addController.productImagePath.value == ''
                          ? Image.asset(defaultImagePath,
                              height: 200, width: 200, fit: BoxFit.fill)
                          : Image.file(
                              File(addController.productImagePath.value),
                              height: 200,
                              width: 200,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Obx(
                          () => Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.all(backgroundDarkColor),
                            value: addController.isNoProductImage.value,
                            onChanged: (value) {
                              addController
                                  .onClickNoProductImageCheckbox(value);
                            },
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "No product image",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(15),
                  OAYSCustomTextField(
                    controller: addController.offerProductNameController,
                    labelText: "Product Name",
                    obscureText: false,
                  ),
                  addVerticalSpace(15),
                  OAYSCustomTextField(
                    controller: addController.offerProductBrandController,
                    labelText: "Brand Name",
                    obscureText: false,
                  ),
                  addVerticalSpace(15),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: OAYSCustomTextField(
                            controller:
                                addController.offerProductCategoryController,
                            labelText: "Category",
                            obscureText: false,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: OAYSCustomTextField(
                            controller:
                                addController.offerProductSubCategoryController,
                            labelText: "Sub category",
                            obscureText: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(15),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: OAYSCustomTextField(
                            controller:
                                addController.offerProductActualPriceController,
                            labelText: "Actual Price",
                            obscureText: false,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: OAYSCustomTextField(
                            controller: addController
                                .offerProductDiscountPriceController,
                            labelText: "Discount Price",
                            obscureText: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(15),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Offer Start Date',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: hintTextColor,
                              ),
                            ),
                            controller:
                                addController.offerProductStartDateController,
                            readOnly: true,
                            onTap: () async {
                              final startDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 0)),
                                lastDate: DateTime(2099),
                              );

                              addController
                                      .offerProductStartDateController.text =
                                  startDate == null
                                      ? ''
                                      : _getFormattedDate(startDate);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Offer End Date',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: hintTextColor,
                              ),
                            ),
                            controller:
                                addController.offerProductEndDateController,
                            readOnly: true,
                            onTap: () async {
                              final endDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 0)),
                                lastDate: DateTime(2099),
                              );

                              addController.offerProductEndDateController.text =
                                  endDate == null
                                      ? ''
                                      : _getFormattedDate(endDate);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(15),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: OAYSCustomTextField(
                            controller:
                                addController.offerProductWeightController,
                            labelText: "Weight",
                            obscureText: false,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: OAYSCustomTextField(
                            controller: addController
                                .offerProductDiscountPercentController,
                            labelText: "Discount %",
                            obscureText: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(15),
                  TextField(
                    controller: addController.offerProductDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: hintTextColor)),
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  addVerticalSpace(25),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 15, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              // setState(() {
                              //   addController.isProductSuccess.value = true;
                              // });
                              addController.addProduct();
                              //   addController.addProduct()?.then((value) {
                              //     Get.snackbar(
                              //       'Info',
                              //       value,
                              //       snackPosition: SnackPosition.BOTTOM,
                              //       colorText: Colors.black,
                              //       backgroundColor: boxFillColor,
                              //     );
                              //     // setState(() {
                              //     //   controller.isProductSuccess.value = false;
                              //     //   // controller.isNoProductImageChecked.value =
                              //     //   //     false;
                              //     //   if (value.contains('Successfully')) {
                              //     //     print(value);
                              //     //     controller.productImagePath.value = '';
                              //     //     controller.isGestureTapDisabled.value =
                              //     //         false;
                              //     //     controller.isNoProductImageChecked.value =
                              //     //         false;
                              //     //   }
                              //     // });
                              //   });
                            },
                            child: const Text("Add"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 30, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              // setState(() {
                              //   controller.isNoProductImageChecked.value =
                              //       false;
                              //   controller.productImagePath.value = '';
                              //   controller.isGestureTapDisabled.value = false;
                              // });
                              addController.cancelProduct();
                            },
                            child: const Text("Cancel"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(50),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _selectImageFromGallery() async {
    // XFile? file = await ImagePicker()
    //     .pickImage(source: ImageSource.gallery, imageQuality: 50);
    addController.productImageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (addController.productImageFile != null) {
      return addController.productImageFile?.path;
    } else {
      return '';
    }
  }

  _getFormattedDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
