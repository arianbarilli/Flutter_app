// lib/viewmodels/weather_viewmodel.dart

import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../repositories/weather_repository.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();

  Weather? _weather;
  bool _isLoading = false;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedWeather = await _repository.fetchWeather(cityName);
      _weather = fetchedWeather;
    } catch (e) {
      _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
