import 'package:flutter/material.dart';
import 'package:tictactoe/view/Home_screen/home_screen.dart';
import 'package:tictactoe/view/Splash_screen/splash_screen.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
