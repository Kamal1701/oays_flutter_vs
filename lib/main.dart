import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:oaysflutter/controllers/bindings/oays_auth_binding.dart';
import 'package:oaysflutter/firebase_options.dart';
import 'package:oaysflutter/screens/oays_signin_screen.dart';
import 'package:oaysflutter/utils/themes/oays_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OAYS',
      initialBinding: OAYSAuthBinding(),
      theme: OAYSTheme.lightTheme,
      home: OAYSSignInScreen(),
    );
  }
}
