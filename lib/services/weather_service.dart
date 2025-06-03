// lib/services/weather_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String _apiKey = '806ea9d63ea8349e2ff35089b9f6e35c';
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> getWeather(String cityName) async {
    final url = '$_baseUrl?q=$cityName&appid=$_apiKey&units=metric&lang=pt_br';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Weather.fromJson(jsonData);
    } else {
      throw Exception('Erro ao buscar clima');
    }
  }
}
