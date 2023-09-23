import 'package:get/get.dart';
import 'package:oaysflutter/models/oays_offer_product_model.dart';

class OAYSOfferProductController extends GetxController {
  final _oaysOffer = OAYSOfferProduct('', '', true, '', '', '', '', '', '', '',
          '', '', '', '', '', '', '', '', '')
      .obs;

  OAYSOfferProduct get oaysOffer => _oaysOffer.value;

  set oaysOffer(OAYSOfferProduct? value) => _oaysOffer.value = value!;
}
