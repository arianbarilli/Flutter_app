import 'package:json_annotation/json_annotation.dart';

part 'holiday.g.dart';

@JsonSerializable()
class Holiday {
  Holiday(this.date, this.localName, this.name, this.countryCode);

  String? date;
  String? localName;
  String? name;
  String? countryCode;

  factory Holiday.fromJson(Map<String, Object?> json) =>
      _$HolidayFromJson(json);
}
