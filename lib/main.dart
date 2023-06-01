import 'package:flutter/material.dart';
import 'package:front/ui/introduction_animation/introduction_animation_screen.dart';
import 'package:front/ui/login/uiLogin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductionAnimationScreen(),
    );
  }
}
