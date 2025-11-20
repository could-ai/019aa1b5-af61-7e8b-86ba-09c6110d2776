import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/home_screen.dart';

void main() {
  runApp(const BiOneApp());
}

class BiOneApp extends StatelessWidget {
  const BiOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'biOne',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
          primary: const Color(0xFF2E7D32), // Forest Green
          secondary: const Color(0xFF81C784), // Light Green
          surface: const Color(0xFFF1F8E9), // Very light green background
        ),
        fontFamily: 'Roboto', // Default, but good for readability
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
