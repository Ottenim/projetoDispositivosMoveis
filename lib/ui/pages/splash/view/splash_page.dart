import 'dart:async';

import 'package:barber/ui/pages/login/login.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => SplashPage());

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      value: 0.1,
      lowerBound: 0.7,
      upperBound: 1.0,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
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
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1.0),
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: SizedBox(
            width: 200,
            height: 200,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
