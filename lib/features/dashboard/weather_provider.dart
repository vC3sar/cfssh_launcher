import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class WeatherData {
  final double temperature;
  final int weatherCode;

  WeatherData({required this.temperature, required this.weatherCode});
}

final weatherProvider = FutureProvider.autoDispose<WeatherData>((ref) async {
  try {
    // 1. Get Location based on IP
    final ipResponse = await http.get(Uri.parse('http://ip-api.com/json/'));
    if (ipResponse.statusCode != 200) throw Exception('No se pudo obtener la IP');
    
    final ipData = json.decode(ipResponse.body);
    final double lat = ipData['lat'];
    final double lon = ipData['lon'];

    // 2. Get Weather from Open-Meteo
    final weatherResponse = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true'));
    
    if (weatherResponse.statusCode != 200) throw Exception('No se pudo obtener el clima');
    
    final weatherData = json.decode(weatherResponse.body);
    final current = weatherData['current_weather'];
    
    return WeatherData(
      temperature: current['temperature'],
      weatherCode: current['weathercode'],
    );
  } catch (e) {
    throw Exception(e.toString());
  }
});
