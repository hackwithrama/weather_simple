import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_simple/models/weather.dart';
import 'package:weather_simple/services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var _isLoading = true;
  // List<String> items = List.generate(20, (index) => "Item $index");

  final _weatherService = WeatherService(dotenv.env['API_KEY']!);
  Weather? _weather;

  // fetch weather
  void fetchWeather() async {
    // get current city
    final zipCode = await _weatherService.getCurrentCity();

    // get weather for city
    final cityWeather = await _weatherService.getWeather(zipCode);

    setState(() {
      _weather = cityWeather;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thundertorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // Future<void> _refresh() async{
  //   await Future.delayed(Duration(seconds: 2)); // Simulating network request
  //   setState(() {
  //     items.insert(0, "New Item ${items.length}");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: RefreshProgressIndicator(),
    );

    if (!_isLoading) {
      mainContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pin_drop,
              color: Colors.white,
              size: 28,
            ),
            Text(
              _weather?.cityName ?? "Failed to get...",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              '${_weather?.temperature.round()}°C',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              _weather?.mainCondition ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: mainContent,
    );
  }
}
