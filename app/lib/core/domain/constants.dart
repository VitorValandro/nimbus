class Constants {
  static const double defaultHorizontalPadding = 3;
  static const double timestampConversorMultiplier = 1000 * 60 * 60;
  static double timestampConversorDivider(double timestamp) =>
      timestamp / 1000 / 60 / 60;
}
