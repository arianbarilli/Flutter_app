import 'package:json_annotation/json_annotation.dart';

part 'available_country.g.dart';

@JsonSerializable()
class AvailableCountry {
  AvailableCountry(this.countryCode, this.name);

  String? countryCode;
  String? name;

  factory AvailableCountry.fromJson(Map<String, Object?> json) =>
      _$AvailableCountryFromJson(json);
}
