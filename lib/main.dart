import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const WheatGuardApp());
}

class WheatGuardApp extends StatelessWidget {
  const WheatGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WheatGuard',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeScreen(),
    );
  }
}
