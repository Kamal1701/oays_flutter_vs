import 'package:flutter/material.dart';
import 'package:oaysflutter/utils/constants/color_constant.dart';
import 'package:oaysflutter/utils/helpers/drawer_widget.dart';

class OAYSHomeScreen extends StatelessWidget {
  const OAYSHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
        ),
        backgroundColor: backgroundDarkColor,
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
      drawer: OAYSNavigationDrawer(),
    );
  }
}
