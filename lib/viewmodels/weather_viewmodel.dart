import 'package:flutter/material.dart';
import '../storage/local_storage_service.dart';
import '../models/weather_model.dart';
import '../repositories/weather_repository.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository repository;

  Weather? _weather;
  bool _isLoading = false;
  List<String> _savedCities = [];

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  List<String> get savedCities => _savedCities;

  WeatherViewModel({required this.repository}) {
    loadSavedCities();
  }

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await repository.fetchWeather(city);
      await LocalStorageService().saveCity(city);
      await loadSavedCities();
    } catch (e) {
      _weather = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadSavedCities() async {
    _savedCities = await LocalStorageService().getSavedCities();
    notifyListeners();
  }
}
