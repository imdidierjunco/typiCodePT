import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Get.to(const HomeScreen());
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/Logo Didier NB.png',
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
