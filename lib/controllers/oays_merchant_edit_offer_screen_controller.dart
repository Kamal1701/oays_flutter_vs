import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oaysflutter/controllers/oays_user_model_controller.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';

class OAYSMerchantEditOfferScreenController extends GetxController {
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

  OAYSMerchantEditOfferScreenController(this.oaysOfferProduct);

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
    getOfferProduct(oaysOfferProduct);
  }

  pickProductImageFromGallery() async {
    if (isGestureTapDisabled.value && isNoProductImage.value) {
      _showMessage('To add image, please uncheck no product image.');
    } else {
      // if (productImageUrl.value != '') {
      //   productImagePath.value = await _selectImageFromGallery();

      //   if (productImagePath.value == '') {
      //     isProductNewImage.value = false;
      //     productImagePath.value = productImageUrl.value;
      //   } else if (productImagePath.value != '') {
      //     isProductNewImage.value = true;
      //   }
      // } else {
      //   productImagePath.value = await _selectImageFromGallery();
      //   if (productImagePath.value != '') {
      //     isProductNewImage.value = true;
      //   }
      productImagePath.value = await _selectImageFromGallery();
      // if (isNetworkUrlAvailable) {
      //   // productImagePath.value = await _selectImageFromGallery();

      //   if (productImagePath.value == '') {
      //     isProductNewImage.value = false;
      //     productImagePath.value = productImageUrl.value;
      //   } else {
      //     isProductNewImage.value = true;
      //   }
      // } else {
      //   // productImagePath.value = await _selectImageFromGallery();
      //   if (productImagePath.value != '') {
      //     isProductNewImage.value = true;
      //   }
      // }

      if (productImagePath.value != '') {
        isProductNewImage.value = true;
      } else {
        if (isNetworkUrlAvailable) {
          // productImagePath.value = await _selectImageFromGallery();
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
      // if (productImageUrl.value != '') {
      //   productImagePath.value = productImageUrl.value;
      // }
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

  getOfferProduct(OAYSOfferProduct offerId) {
    productImageUrl.value = offerId.offerImageUrl;
    productImagePath.value = offerId.offerImageUrl;
    isNoProductImage.value = offerId.isOfferImageBlank;
    if (isNoProductImage.value) {
      isGestureTapDisabled.value = true;
    } else {
      isGestureTapDisabled.value = false;
      isNetworkUrlAvailable = true;
    }
    offerProductNameController.text = offerId.offerProductName;
    offerProductBrandController.text = offerId.offerProductBrandName;
    offerProductCategoryController.text = offerId.offerProductCategory;
    offerProductSubCategoryController.text = offerId.offerProductSubcategory;
    offerProductActualPriceController.text = offerId.offerProductActualPrice;
    offerProductDiscountPriceController.text =
        offerId.offerProductDiscountPrice;
    offerProductStartDateController.text = offerId.offerProductStartDate;
    offerProductEndDateController.text = offerId.offerProductEndDate;
    offerProductWeightController.text = offerId.offerProductWeigh;
    offerProductDiscountPercentController.text =
        offerId.offerProductDiscountPerc;
    offerProductDescriptionController.text = offerId.offerProductDescription;
  }
}
