import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        children: [
          Expanded(child: Center(child: Lottie.asset("Assets/Animations/AuthLottieAnimation.json", fit: BoxFit.contain))),
          Expanded(child: SizedBox()),
        ],
      )
    );
  }
}
