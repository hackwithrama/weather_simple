import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather_simple/models/weather.dart';

class WeatherService {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  const WeatherService(this.apiKey);

  Future<Weather> getWeather(String zipCode) async {
    final url = Uri.parse('$baseUrl?zip=$zipCode,IN&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);
      return Weather.fromJson(jsonDecode(response.body));
    } catch (error) {
      throw Exception('Something went wrong : $error');
    }
  }

  Future<String> getCurrentCity() async {
    // Get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Get current location of user
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Convert location into list of placemark object
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extract cityname from first placemarks
    String? zip = placemarks[0].postalCode;

    if (zip == null) {
      return "";
    }

    return zip;
  }
}
