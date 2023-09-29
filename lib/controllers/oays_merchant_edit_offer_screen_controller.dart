import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/screens/oays_home_screen.dart';
import 'package:oaysflutter/screens/oays_merchant_view_offer_screen.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSMerchantModifyOfferScreenController extends GetxController {
  OAYSUserController userController =
      Get.put<OAYSUserController>(OAYSUserController());

  final isGestureTapDisabled = true.obs;
  final productImagePath = ''.obs;
  final isNoProductImage = false.obs;
  final productImageUrl = ''.obs;
  final isProductNewImage = false.obs;
  final isUpdateProductSuccess = false.obs;
  late XFile? productImageFile;
  bool isNetworkUrlAvailable = false;

  OAYSOfferProduct oaysOfferProduct = OAYSOfferProduct('', '', true, '', '', '',
      '', '', '', '', '', '', '', '', '', '', '', '', '');

  OAYSMerchantModifyOfferScreenController(this.oaysOfferProduct);

  // var offerId = '';
  final offerProductNameController = TextEditingController();
  final offerProductBrandController = TextEditingController();
  final offerProductCategoryController = TextEditingController();
  final offerProductSubCategoryController = TextEditingController();
  final offerProductActualPriceController = TextEditingController();
  final offerProductDiscountPriceController = TextEditingController();
  final offerProductStartDateController = TextEditingController();
  final offerProductEndDateController = TextEditingController();
  final offerProductWeightController = TextEditingController();
  final offerProductDiscountPercentController = TextEditingController();
  final offerProductDescriptionController = TextEditingController();

  final _storageInstance = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
    userController = Get.find<OAYSUserController>();
    getOfferProduct(oaysOfferProduct);
  }

  pickProductImageFromGallery() async {
    if (isGestureTapDisabled.value && isNoProductImage.value) {
      _showMessage('To add image, please uncheck no product image.');
    } else {
      productImagePath.value = await _selectImageFromGallery();

      if (productImagePath.value != '') {
        isProductNewImage.value = true;
      } else {
        if (isNetworkUrlAvailable) {
          isProductNewImage.value = false;
          productImagePath.value = productImageUrl.value;
        }
      }

      if (productImagePath.value != '' && isNoProductImage.value) {
        isGestureTapDisabled.value = true;
      }
    }
  }

  onClickNoProductImageCheckbox(bool? isChecked) {
    isNoProductImage.value = isChecked!;
    if (isNoProductImage.value) {
      productImagePath.value = '';
      isGestureTapDisabled.value = isChecked;
    } else {
      if (isNetworkUrlAvailable) {
        productImagePath.value = productImageUrl.value;
      }
      isProductNewImage.value = false;
      isGestureTapDisabled.value = isChecked;
    }
  }

  _selectImageFromGallery() async {
    productImageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (productImageFile != null) {
      return productImageFile?.path;
    } else {
      return '';
    }
  }

  void deleteProduct() async {
    String? status = await OAYSDatabaseService().deleteOfferProduct(
        userController.oaysUser.userId, oaysOfferProduct.offerProductId);
    if (status == 'Success') {
      if (!oaysOfferProduct.isOfferImageBlank) {
        await _deleteImageReference(oaysOfferProduct.offerImageUrl);
      }
      _showMessage('Offer Product deleted successfully');
      // Get.off(() => OAYSMerchantViewOfferScreen());
      Get.offAll(() => OAYSHomeScreen());
    } else {
      _showMessage(status);
    }
  }

  void _showMessage(String info) {
    Get.snackbar(
      'Info',
      info,
      snackPosition: SnackPosition.BOTTOM,
      colorText: oaysFontColor,
      backgroundColor: boxFillColor,
    );
  }

  void getOfferProduct(OAYSOfferProduct offerProduct) {
    productImageUrl.value = offerProduct.offerImageUrl;
    productImagePath.value = offerProduct.offerImageUrl;
    isNoProductImage.value = offerProduct.isOfferImageBlank;
    if (isNoProductImage.value) {
      isGestureTapDisabled.value = true;
    } else {
      isGestureTapDisabled.value = false;
      isNetworkUrlAvailable = true;
    }
    offerProductNameController.text = offerProduct.offerProductName;
    offerProductBrandController.text = offerProduct.offerProductBrandName;
    offerProductCategoryController.text = offerProduct.offerProductCategory;
    offerProductSubCategoryController.text =
        offerProduct.offerProductSubcategory;
    offerProductActualPriceController.text =
        offerProduct.offerProductActualPrice;
    offerProductDiscountPriceController.text =
        offerProduct.offerProductDiscountPrice;
    offerProductStartDateController.text = offerProduct.offerProductStartDate;
    offerProductEndDateController.text = offerProduct.offerProductEndDate;
    offerProductWeightController.text = offerProduct.offerProductWeigh;
    offerProductDiscountPercentController.text =
        offerProduct.offerProductDiscountPerc;
    offerProductDescriptionController.text =
        offerProduct.offerProductDescription;
  }

  Future<void> updateProduct() async {
    if (offerProductNameController.text.isEmpty ||
        offerProductBrandController.text.isEmpty ||
        offerProductCategoryController.text.isEmpty ||
        offerProductSubCategoryController.text.isEmpty ||
        offerProductActualPriceController.text.isEmpty ||
        offerProductDiscountPriceController.text.isEmpty ||
        offerProductDiscountPercentController.text.isEmpty ||
        offerProductStartDateController.text.isEmpty ||
        offerProductEndDateController.text.isEmpty ||
        offerProductWeightController.text.isEmpty ||
        offerProductDescriptionController.text.isEmpty) {
      _showMessage('Please fill the required details.');
    } else if (!isNoProductImage.value && productImagePath.value == '') {
      _showMessage('Please add offer product image.');
    } else {
      DateFormat dateFormat = DateFormat('dd-MM-yyyy');
      final startDate = dateFormat.parse(offerProductStartDateController.text);
      final endDate = dateFormat.parse(offerProductEndDateController.text);
      isUpdateProductSuccess.value = true;
      if (startDate.compareTo(endDate) <= 0) {
        if (isProductNewImage.value) {
          final Reference storageReference = _storageInstance.ref().child(
                '$offerProductImagePath/${DateTime.now().millisecondsSinceEpoch.toString()}',
              );

          UploadTask uploadTask =
              storageReference.putFile(File(productImageFile!.path));
          await uploadTask.whenComplete(() async {
            productImageUrl.value = await storageReference.getDownloadURL();
          });
          if (oaysOfferProduct.offerImageUrl != '') {
            await _deleteImageReference(oaysOfferProduct.offerImageUrl);
          }
        } else {
          if (isNoProductImage.value) {
            productImageUrl.value = '';
            if (!oaysOfferProduct.isOfferImageBlank) {
              await _deleteImageReference(oaysOfferProduct.offerImageUrl);
            }
          } else {
            productImageUrl.value = oaysOfferProduct.offerImageUrl;
          }
        }
        OAYSOfferProduct op = OAYSOfferProduct(
          oaysOfferProduct.offerProductId,
          productImageUrl.value,
          isNoProductImage.value,
          offerProductNameController.text.trim(),
          offerProductBrandController.text.trim(),
          offerProductCategoryController.text.trim(),
          offerProductSubCategoryController.text.trim(),
          offerProductActualPriceController.text.trim(),
          offerProductDiscountPriceController.text.trim(),
          offerProductStartDateController.text,
          offerProductEndDateController.text,
          offerProductWeightController.text.trim(),
          offerProductDiscountPercentController.text.trim(),
          offerProductDescriptionController.text.trim(),
          userController.oaysUser.shopName,
          userController.oaysUser.shopStreetName,
          userController.oaysUser.shopCity,
          userController.oaysUser.shopState,
          userController.oaysUser.shopPincode,
        );
        String? status = await OAYSDatabaseService().updateOfferProduct(op,
            userController.oaysUser.userId, oaysOfferProduct.offerProductId);
        if (status == 'Success') {
          _showMessage('Offer updated Successfully.');
          // Get.off(() => OAYSMerchantViewOfferScreen());
          Get.offAll(() => OAYSHomeScreen());
        } else {
          _showMessage(status);
        }
        isUpdateProductSuccess.value = !isUpdateProductSuccess.value;
      } else {
        _showMessage('Offer end date should be greater than offer start date');
        isUpdateProductSuccess.value = !isUpdateProductSuccess.value;
      }
    }
  }

  Future<void> _deleteImageReference(String firestoreImageUrl) async {
    final storageReference = _storageInstance.refFromURL(firestoreImageUrl);
    await storageReference.delete();
  }
}
