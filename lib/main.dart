import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(1, 255, 79, 0));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: kColorScheme,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: Placeholder(),
    );
  }
}
