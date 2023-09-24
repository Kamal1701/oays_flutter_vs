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
