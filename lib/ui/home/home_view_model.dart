import 'package:flutter/material.dart';
import 'package:flutter_application_1/command.dart';
import 'package:flutter_application_1/data/repositories/repository.dart';
import 'package:flutter_application_1/data/services/model/available_country.dart';
import 'package:flutter_application_1/result.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required Repository repository}) : _repository = repository {
    getAvailableCountries = Command0(_getAvailableCountries);
    getAvailableCountries.execute();
  }

  final Repository _repository;

  List<AvailableCountry>? _availableCountries;
  List<AvailableCountry>? get availableCountries => _availableCountries;

  late Command0 getAvailableCountries;

  Future<Result> _getAvailableCountries() async {
    try {
      final result = await _repository.getAvailableCountries();
      switch (result) {
        case Ok<List<AvailableCountry>>():
          _availableCountries = result.value;
        case Error<void>():
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
