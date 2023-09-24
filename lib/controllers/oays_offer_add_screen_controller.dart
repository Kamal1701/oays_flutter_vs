import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/services/oays_database_service.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';

class OAYSOfferAddScreenController extends GetxController {
  // static OAYSOfferAddScreenController get instance => Get.find();

  OAYSUserController userController =
      Get.put<OAYSUserController>(OAYSUserController());

  final isGestureTapDisabled = true.obs;
  final productImagePath = ''.obs;
  final isNoProductImage = false.obs;
  final productImageUrl = ''.obs;
  final isProductSuccess = false.obs;
  late XFile? productImageFile;

  var offerId = '';
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

  @override
  void onInit() {
    super.onInit();
    userController = Get.find<OAYSUserController>();
  }

  pickProductImageFromGallery() async {
    if (isGestureTapDisabled.value && isNoProductImage.value) {
      _showMessage('To add image, please uncheck no product image.');
    } else {
      productImagePath.value = await _selectImageFromGallery();
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

  Future<void> addProduct() async {
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
      isProductSuccess.value = true;
      if (startDate.compareTo(endDate) <= 0) {
        if (isNoProductImage.value) {
          productImageUrl.value = '';
        } else {
          final Reference storageReference =
              FirebaseStorage.instance.ref().child(
                    '$offerProductImagePath/${DateTime.now().millisecondsSinceEpoch.toString()}',
                  );
          UploadTask uploadTask =
              storageReference.putFile(File(productImageFile!.path));
          await uploadTask.whenComplete(() async {
            productImageUrl.value = await storageReference.getDownloadURL();
          });
        }

        await OAYSDatabaseService()
            .getOfferProductId(userController.oaysUser.userId)
            .then(
          (value) {
            offerId = value;
          },
        );

        OAYSOfferProduct op = OAYSOfferProduct(
          offerId,
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
        String? status = await OAYSDatabaseService()
            .addOfferProduct(op, userController.oaysUser.userId, offerId);
        if (status == 'Success') {
          clearScreen();
          _showMessage('Offer Added Successfully.');
        } else {
          clearScreen();
          _showMessage(status);
        }
        isProductSuccess.value = false;
      } else {
        _showMessage('Offer end date should be greater than offer start date');
      }
    }
  }

  Future<void> cancelProduct() async {
    clearScreen();
  }

  void clearScreen() {
    isNoProductImage.value = false;
    productImagePath.value = '';
    offerProductNameController.text = '';
    offerProductBrandController.text = '';
    offerProductCategoryController.text = '';
    offerProductSubCategoryController.text = '';
    offerProductActualPriceController.text = '';
    offerProductDiscountPriceController.text = '';
    offerProductDiscountPercentController.text = '';
    offerProductStartDateController.text = '';
    offerProductEndDateController.text = '';
    offerProductWeightController.text = '';
    offerProductDescriptionController.text = '';
  }

  _showMessage(String info) {
    Get.snackbar(
      'Info',
      info,
      snackPosition: SnackPosition.BOTTOM,
      colorText: oaysFontColor,
      backgroundColor: boxFillColor,
    );
  }
}
