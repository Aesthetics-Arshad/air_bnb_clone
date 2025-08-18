import 'dart:async';
import 'package:flutter/material.dart';
import '../app_state.dart';
import 'login_page.dart';
import 'home_page.dart';

const kAirbnbCoral = Color(0xFFFF385C);

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
        ..forward();
  late final Animation<double> _scale =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      if (AppState.isLoggedIn) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAirbnbCoral,
      body: Center(
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/img/logo.png',
              width: 68,
              height: 68,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.home_rounded,
                size: 48,
                color: kAirbnbCoral,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
