import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_simple/screens/weather_screen.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(1, 240, 248, 255));

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoMonoTextTheme().copyWith(
            titleLarge: TextStyle(
              color: kColorScheme.onPrimary,
              fontSize: 28,
              letterSpacing: 3,
              // fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              color: kColorScheme.onPrimary,
              fontSize: 24,
              letterSpacing: 2,
            )),
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: kColorScheme.primary,
      ),
      home: WeatherScreen(),
    );
  }
}
