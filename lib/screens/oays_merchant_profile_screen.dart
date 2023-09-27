import 'package:flutter/material.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';
import 'package:oaysflutter/utils/helpers/drawer_widget.dart';

class OAYSMerchantProfileScreen extends StatelessWidget {
  const OAYSMerchantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          profile,
        ),
        backgroundColor: backgroundDarkColor,
      ),
      body: const Center(
        child: Text('Profile'),
      ),
      drawer: OAYSNavigationDrawer(),
    );
  }
}
