import 'package:flutter_application_1/data/services/api/api_client.dart';
import 'package:flutter_application_1/data/services/model/available_country.dart';
import 'package:flutter_application_1/data/services/model/holiday.dart';
import 'package:flutter_application_1/result.dart';

class Repository {
  Repository({required APIClient client}) : _client = client;

  final APIClient _client;

  Future<Result<List<AvailableCountry>>> getAvailableCountries() async {
    try {
      return await _client.getAvailableCountries();
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<List<Holiday>>> getHolidays({
    required int year,
    required String countryCode,
  }) async {
    try {
      return await _client.getHolidays(countryCode: countryCode, year: year);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
