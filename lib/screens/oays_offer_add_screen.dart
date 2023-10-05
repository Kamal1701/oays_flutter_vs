import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oaysflutter/components/oays_textfield.dart';
import 'package:oaysflutter/controllers/oays_offer_add_screen_controller.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';
import 'package:oaysflutter/utils/helpers/drawer_widget.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSOfferAddScreen extends StatelessWidget {
  final addController = Get.put(OAYSOfferAddScreenController());
  OAYSOfferAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => addController.isAddProductSuccess.value
          ? progressIndicator()
          : Stack(
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
                            onTap: () =>
                                addController.pickProductImageFromGallery(),
                            child: Obx(
                              () => addController.productImagePath.value == ''
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.asset(defaultUpdateImagePath,
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.fill),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.file(
                                        File(addController
                                            .productImagePath.value),
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.fill,
                                      ),
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
                                    fillColor: MaterialStateProperty.all(
                                        backgroundDarkColor),
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
                            controller:
                                addController.offerProductNameController,
                            labelText: "Product Name",
                            obscureText: false,
                          ),
                          addVerticalSpace(15),
                          OAYSCustomTextField(
                            controller:
                                addController.offerProductBrandController,
                            labelText: "Brand Name",
                            obscureText: false,
                          ),
                          addVerticalSpace(15),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: OAYSCustomTextField(
                                    controller: addController
                                        .offerProductCategoryController,
                                    labelText: "Category",
                                    obscureText: false,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: OAYSCustomTextField(
                                    controller: addController
                                        .offerProductSubCategoryController,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: TextField(
                                    controller: addController
                                        .offerProductActualPriceController,
                                    obscureText: false,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.]'))
                                    ],
                                    decoration: InputDecoration(
                                        labelText: "Actual Price",
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: hintTextColor)),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: oaysFontColor,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: TextField(
                                    controller: addController
                                        .offerProductDiscountPriceController,
                                    obscureText: false,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.]'))
                                    ],
                                    decoration: InputDecoration(
                                        labelText: "Discount Price",
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: hintTextColor)),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: oaysFontColor,
                                    ),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
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
                                    controller: addController
                                        .offerProductStartDateController,
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
                                              .offerProductStartDateController
                                              .text =
                                          startDate == null
                                              ? ''
                                              : _getFormattedDate(startDate);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                                    controller: addController
                                        .offerProductEndDateController,
                                    readOnly: true,
                                    onTap: () async {
                                      final endDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now()
                                            .subtract(const Duration(days: 0)),
                                        lastDate: DateTime(2099),
                                      );
                                      addController
                                              .offerProductEndDateController
                                              .text =
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: OAYSCustomTextField(
                                    controller: addController
                                        .offerProductWeightController,
                                    labelText: "Weight",
                                    obscureText: false,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: TextField(
                                    controller: addController
                                        .offerProductDiscountPercentController,
                                    obscureText: false,
                                    onTap: () {
                                      addController.doDiscountPercentageCalc();
                                    },
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.]'))
                                    ],
                                    decoration: InputDecoration(
                                        labelText: "Discount %",
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: hintTextColor)),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: oaysFontColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          addVerticalSpace(15),
                          TextField(
                            controller:
                                addController.offerProductDescriptionController,
                            decoration: InputDecoration(
                                hintText: 'Description',
                                labelText: 'Description',
                                labelStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: hintTextColor)),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18.0),
                          ),
                          addVerticalSpace(25),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 15, 0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      addController.addProduct();
                                    },
                                    child: const Text("Add"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 30, 0),
                                  child: ElevatedButton(
                                    onPressed: () async {
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
            ),
    );
  }

  _getFormattedDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
