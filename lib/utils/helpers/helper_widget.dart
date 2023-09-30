import 'package:flutter/material.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget progressIndicator() {
  return Stack(
    children: [
      Opacity(
        opacity: 0.7,
        child: ModalBarrier(
          color: backgroundLightColor,
          dismissible: false,
        ),
      ),
      const Center(
        child: CircularProgressIndicator(),
      ),
    ],
  );
}

Widget noProductTextWidget() {
  return Container(
    // padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0),
    decoration: BoxDecoration(
      color: backgroundLightColor,
    ),
    child: Center(
      child: Text(
        "No products to view...",
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: oaysFontColor,
        ),
      ),
    ),
  );
}

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('OAYS'),
        content: Text('Are you sure to delete this offer?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              // Proceed further
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
