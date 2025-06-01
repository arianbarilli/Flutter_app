import 'dart:convert';

import 'package:flutter_application_1/data/services/model/available_country.dart';
import 'package:flutter_application_1/data/services/model/holiday.dart';
import 'package:flutter_application_1/result.dart';
import 'package:http/http.dart' as http;

class APIClient {
  final String _host = "https://date.nager.at/api/v3/";

  Future<Result<List<AvailableCountry>>> getAvailableCountries() async {
    try {
      final response = await http.get(Uri.parse('${_host}AvailableCountries'));
      if (response.statusCode == 200) {
        List myList = jsonDecode(response.body);
        return Result.ok(
          myList.map((e) => AvailableCountry.fromJson(e)).toList(),
        );
      } else {
        return Result.error(Exception());
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<List<Holiday>>> getHolidays({
    required int year,
    required String countryCode,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${_host}publicholidays/$year/$countryCode'),
      );
      if (response.statusCode == 200) {
        List myList = jsonDecode(response.body);
        return Result.ok(myList.map((e) => Holiday.fromJson(e)).toList());
      } else {
        return Result.error(Exception());
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
