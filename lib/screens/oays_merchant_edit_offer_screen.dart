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
          : WillPopScope(
              onWillPop: () async {
                // Show a dialog to confirm with the user
                // bool shouldPop = await showDialog(
                //   context: context,
                //   builder: (context) => AlertDialog(
                //     backgroundColor: backgroundLightColor,
                //     title: Text(
                //       'OAYS Info',
                //       style: TextStyle(
                //         color: oaysFontColor,
                //       ),
                //     ),
                //     content: Text(
                //       'Are you sure to leave this page ?',
                //       style: TextStyle(
                //         color: oaysFontColor,
                //         fontSize: 18,
                //       ),
                //     ),
                //     actions: [
                //       TextButton(
                //         onPressed: () => Navigator.pop(context, false),
                //         child: Text(
                //           'No',
                //           style: TextStyle(
                //             color: oaysFontColor,
                //             fontSize: 16,
                //           ),
                //         ),
                //       ),
                //       TextButton(
                //         onPressed: () => Navigator.pop(context, true),
                //         child: Text(
                //           'Yes',
                //           style: TextStyle(color: oaysFontColor),
                //         ),
                //       ),
                //     ],
                //   ),
                // );

                // // If the user confirms, pop the current screen
                // return shouldPop;
                // print(backToViewScreenConfirmation(context));
                return backToViewScreenConfirmation(context);
              },
              child: SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text(modifyOffer),
                    backgroundColor: backgroundDarkColor,
                  ),
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
                              onTap: () => updateController
                                  .pickProductImageFromGallery(),
                              child: Obx(
                                () => updateController.productImagePath.value ==
                                        ''
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: Image.asset(
                                            defaultUpdateImagePath,
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
                                      value: updateController
                                          .isNoProductImage.value,
                                      onChanged: (value) {
                                        updateController
                                            .onClickNoProductImageCheckbox(
                                                value);
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
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
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                                      controller: updateController
                                          .offerProductStartDateController,
                                      readOnly: true,
                                      onTap: () async {
                                        final startDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now().subtract(
                                              const Duration(days: 0)),
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
                                      controller: updateController
                                          .offerProductEndDateController,
                                      readOnly: true,
                                      onTap: () async {
                                        final endDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now().subtract(
                                              const Duration(days: 0)),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: TextField(
                                      controller: updateController
                                          .offerProductDiscountPercentController,
                                      obscureText: false,
                                      onTap: () {
                                        updateController
                                            .doDiscountPercentageCalc();
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
                                        showAlertDialog(context);
                                        // updateController.deleteProduct();
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
              ),
            ),
    );
  }

  _getFormattedDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [backgroundLightColor, backgroundLightColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                addVerticalSpace(10.0),
                Text(
                  'OAYS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: oaysFontColor,
                    fontSize: 18,
                  ),
                ),
                addVerticalSpace(15.0),
                Text(
                  'Are you sure to delete this offer?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: oaysFontColor,
                  ),
                ),
                addVerticalSpace(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            Get.back();
                            updateController.cancelDialogBox();
                          },
                          focusNode: FocusNode(),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 16,
                              color: oaysFontColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            Get.back();
                            updateController.deleteProduct();
                          },
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              fontSize: 16,
                              color: oaysFontColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> backToViewScreenConfirmation(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [backgroundLightColor, backgroundLightColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                addVerticalSpace(10.0),
                Text(
                  'OAYS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: oaysFontColor,
                    fontSize: 18,
                  ),
                ),
                addVerticalSpace(15.0),
                Text(
                  'Are you sure to leave this page without changes?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: oaysFontColor,
                  ),
                ),
                addVerticalSpace(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // Get.back();
                            Navigator.pop(context, false);
                            // updateController.cancelDialogBox();
                          },
                          focusNode: FocusNode(),
                          child: Text(
                            "No",
                            style: TextStyle(
                              fontSize: 16,
                              color: oaysFontColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context, true);
                            // updateController.deleteProduct();
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(
                              fontSize: 16,
                              color: oaysFontColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
