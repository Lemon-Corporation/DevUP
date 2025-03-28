part of values;

class AppColors {
  static List<List<Color>> ballColors = [
    [
      HexColor.fromHex("87D3DF"),
      HexColor.fromHex("DEABEF"),
    ],
    [
      HexColor.fromHex("FC946E"),
      HexColor.fromHex("FFD996"),
    ],
    [
      HexColor.fromHex("87C76F"),
      HexColor.fromHex("87C76F"),
    ],
    [
      HexColor.fromHex("E7B2EF"),
      HexColor.fromHex("EEFCCF"),
    ],
    [
      HexColor.fromHex("8CE0DF"),
      HexColor.fromHex("8CE0DF"),
    ],
    [
      HexColor.fromHex("353645"),
      HexColor.fromHex("1E2027"),
    ],
    [
      HexColor.fromHex("FDA7FF"),
      HexColor.fromHex("FDA7FF"),
    ],
    [
      HexColor.fromHex("899FFE"),
      HexColor.fromHex("899FFE"),
    ],
    [
      HexColor.fromHex("FC946E"),
      HexColor.fromHex("FFD996"),
    ],
    [
      HexColor.fromHex("87C76F"),
      HexColor.fromHex("87C76F"),
    ],
  ];

  // Основные цвета
  static final Color primary = HexColor.fromHex("5B5FEF");
  static final Color secondary = HexColor.fromHex("00C9B1");
  static final Color tertiary = HexColor.fromHex("FF6B6B");

  // Фоновые цвета
  static final Color background = Colors.white;
  static final Color surface = HexColor.fromHex("F8F9FA");
  static final Color cardBackground = HexColor.fromHex("F8F9FA");

  // Цвета текста
  static final Color textPrimary = HexColor.fromHex("1F222F");
  static final Color textSecondary = HexColor.fromHex("6B6F80");
  static final Color textLight = HexColor.fromHex("9EA0A5");

  // Цвета состояний
  static final Color success = HexColor.fromHex("4CAF50");
  static final Color warning = HexColor.fromHex("FFC107");
  static final Color error = HexColor.fromHex("FF6B6B");
  static final Color info = HexColor.fromHex("2196F3");

  // Цвета для геймификации
  static final Color energy = HexColor.fromHex("FFC107");
  static final Color xp = HexColor.fromHex("5B5FEF");
  static final Color level = HexColor.fromHex("00C9B1");

  // Цвета для прогресса
  static final Color progressLow = HexColor.fromHex("FF6B6B");
  static final Color progressMedium = HexColor.fromHex("FFC107");
  static final Color progressHigh = HexColor.fromHex("4CAF50");

  // Устаревшие цвета (для обратной совместимости)
  static final Color primaryBackgroundColor = HexColor.fromHex("FFFFFF");
  static final Color lightMauveBackgroundColor = HexColor.fromHex("C395FC");
  static final Color primaryAccentColor = HexColor.fromHex("5B5FEF");
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

// ranges from 0.0 to 1.0

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
