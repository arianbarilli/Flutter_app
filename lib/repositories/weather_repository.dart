// lib/repositories/weather_repository.dart

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherRepository {
  final WeatherService _weatherService = WeatherService();

  Future<Weather> fetchWeather(String cityName) async {
    return await _weatherService.getWeather(cityName);
  }
}
