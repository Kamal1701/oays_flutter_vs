import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oaysflutter/components/oays_textfield.dart';
import 'package:oaysflutter/controllers/oays_merchant_edit_offer_screen_controller.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';
import 'package:oaysflutter/utils/helpers/helper_widget.dart';

class OAYSMerchantModifyOfferScreen extends StatelessWidget {
  final updateController = Get.put(OAYSMerchantModifyOfferScreenController(
      Get.arguments as OAYSOfferProduct));
  OAYSMerchantModifyOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => updateController.isUpdateProductSuccess.value
          ? progressIndicator()
          : Scaffold(
              appBar: AppBar(
                title: const Text(modifyOffer),
                backgroundColor: backgroundDarkColor,
              ),
              // drawer: OAYSNavigationDrawer(),
              body: Container(
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
                              updateController.pickProductImageFromGallery(),
                          child: Obx(
                            () => updateController.productImagePath.value == ''
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.asset(defaultUpdateImagePath,
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.fill),
                                  )
                                : updateController.isProductNewImage.value
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: Image.file(
                                          File(updateController
                                              .productImagePath.value),
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: Image.network(
                                          updateController
                                              .productImagePath.value,
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(
                                () => Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.all(
                                      backgroundDarkColor),
                                  value:
                                      updateController.isNoProductImage.value,
                                  onChanged: (value) {
                                    updateController
                                        .onClickNoProductImageCheckbox(value);
                                  },
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
                        ),
                        addVerticalSpace(15),
                        OAYSCustomTextField(
                          controller:
                              updateController.offerProductNameController,
                          labelText: "Product Name",
                          obscureText: false,
                        ),
                        addVerticalSpace(15),
                        OAYSCustomTextField(
                          controller:
                              updateController.offerProductBrandController,
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
                                  controller: updateController
                                      .offerProductCategoryController,
                                  labelText: "Category",
                                  obscureText: false,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: OAYSCustomTextField(
                                  controller: updateController
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: TextField(
                                  controller: updateController
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
                                // OAYSCustomTextField(
                                //   controller: updateController
                                //       .offerProductActualPriceController,
                                //   labelText: "Actual Price",
                                //   obscureText: false,
                                // ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: TextField(
                                  controller: updateController
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
                                // OAYSCustomTextField(
                                //   controller: updateController
                                //       .offerProductDiscountPriceController,
                                //   labelText: "Discount Price",
                                //   obscureText: false,
                                // ),
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
                                  controller: updateController
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
                                    updateController
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
                                  controller: updateController
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
                                    updateController
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: OAYSCustomTextField(
                                  controller: updateController
                                      .offerProductWeightController,
                                  labelText: "Weight",
                                  obscureText: false,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: TextField(
                                  controller: updateController
                                      .offerProductDiscountPercentController,
                                  obscureText: false,
                                  onTap: () {
                                    updateController.doDiscountPercentageCalc();
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
                                // OAYSCustomTextField(
                                //   controller: updateController
                                //       .offerProductDiscountPercentController,
                                //   labelText: "Discount %",
                                //   obscureText: false,
                                // ),
                              ),
                            ),
                          ],
                        ),
                        addVerticalSpace(15),
                        TextField(
                          controller: updateController
                              .offerProductDescriptionController,
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
                                    updateController.updateProduct();
                                  },
                                  child: const Text("Update"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 30, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    updateController.deleteProduct();
                                  },
                                  child: const Text("Delete"),
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
            ),
      // Obx(
      //   () => addController.isProductSuccess.value
      //       ? const Stack(
      //           children: [
      //             Opacity(
      //               opacity: 0.5,
      //               child: ModalBarrier(
      //                 color: Colors.black,
      //                 dismissible: false,
      //               ),
      //             ),
      //             Center(
      //               child: CircularProgressIndicator(),
      //             ),
      //           ],
      //         )
      //       : Container(),
      // )
      // ],
    );
  }

  _getFormattedDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
