abstract final class Routes {
  static const home = '/';
  static const holidays = '/$holidaysRelative';
  static const holidaysRelative = 'holidays';
  static String holidayWithCountryCode(String countryCode) =>
      '$holidays/$countryCode';
}
