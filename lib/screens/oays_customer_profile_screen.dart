import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/constants/string_constant.dart';
import 'package:oaysflutter/utils/helpers/drawer_widget.dart';

class OAYSCustomerProfileScreen extends StatelessWidget {
  const OAYSCustomerProfileScreen({super.key});

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
