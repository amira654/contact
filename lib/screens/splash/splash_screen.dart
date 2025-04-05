import 'package:contact_app/core/assets_manager.dart';
import 'package:contact_app/core/routes_manager.dart';
import 'package:flutter/material.dart';

import '../../core/colors_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlue,
      body: Center(
        child: Image.asset(
          AssetsManager.splashScreenBackGround,
        ),
      ),
    );
  }
}
