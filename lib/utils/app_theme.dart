import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// More flexible and various color definitions
class AppColors {
  static const Color primary = Color(0xFF2CCB67);
  static const Color secondary = Color(
    0xFF1EBC46,
  ); //ini ganti aja kalo kurang pas
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFFFA000);
  static const Color success = Color(0xFF388E3C);
  static const Color info = Color(0xFF1976D2);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textInverse = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFFFC107);
  static const Color border = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFBDBDBD);


  //color palet onboarding
  // hijo muda agak kuning dikit
  static const Color lightLime = Color(0xFFE8FCD1);

  //ijo muda pastel
  static const Color mintGreen = Color(0xFFA5F4D0);

  static const Color darkGreen = Color(0xFF124430); //hijo gelap untuk teks
  static const Color emeraldGreen = Color(0xFF008236);
  static const Color brightGreen = Color(0xFF27C863);



}

// More flexible and various text styles

String formatHarga(value) {
  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  ).format(value);
}

String formatTanggal(dynamic value) {
  try {
    final date = value is DateTime ? value : DateTime.parse(value.toString());
    return DateFormat('dd MMM yyyy').format(date);
  } catch (e) {
    return '-';
  }
}

class AppTextStyles {
  static const TextStyle textItalic = TextStyle(
    fontSize: 16,
    fontFamily: 'Plus Jakarta Sans',
    fontStyle: FontStyle.italic,
    color: AppColors.textPrimary,
  );
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'Plus Jakarta Sans',
  );
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Plus Jakarta Sans',
  );
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: 'Plus Jakarta Sans',
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: 'Plus Jakarta Sans',
  );
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
    fontFamily: 'Plus Jakarta Sans',
  );
  static const TextStyle bodyBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'Plus Jakarta Sans',
  );
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    color: AppColors.textPrimary,
    fontFamily: 'Plus Jakarta Sans',
  );
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textInverse,
    fontFamily: 'Plus Jakarta Sans',
    letterSpacing: 1.2,
  );
  static const TextStyle error = TextStyle(
    fontSize: 14,
    color: AppColors.error,
    fontFamily: 'Plus Jakarta Sans',
  );
}

// More flexible ThemeData
final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme(
    primary: AppColors.primary,
    primaryContainer: AppColors.secondary,
    secondary: AppColors.accent,
    secondaryContainer: AppColors.secondary,
    surface: AppColors.surface,
    error: AppColors.error,
    onPrimary: AppColors.textInverse,
    onSecondary: AppColors.textInverse,
    onSurface: AppColors.textPrimary,
    onError: AppColors.textInverse,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    displayLarge: AppTextStyles.heading1,
    displayMedium: AppTextStyles.heading2,
    displaySmall: AppTextStyles.heading3,
    headlineMedium: AppTextStyles.heading2,
    headlineSmall: AppTextStyles.heading3,
    titleLarge: AppTextStyles.heading2,
    titleMedium: AppTextStyles.subtitle,
    titleSmall: AppTextStyles.caption,
    bodyLarge: AppTextStyles.body,
    bodyMedium: AppTextStyles.body,
    bodySmall: AppTextStyles.caption,
    labelLarge: AppTextStyles.button,
    labelSmall: AppTextStyles.caption,
  ),
  fontFamily: 'Montserrat',
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textInverse,
    elevation: 0,
    titleTextStyle: AppTextStyles.heading2.copyWith(color: AppColors.textInverse),
    iconTheme: IconThemeData(color: AppColors.textInverse),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.primary,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textInverse,
      textStyle: AppTextStyles.button,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
    ),
    labelStyle: TextStyle(color: AppColors.textSecondary),
    hintStyle: TextStyle(color: AppColors.textSecondary),
  ),
  cardColor: AppColors.surface,
  disabledColor: AppColors.disabled,
  dividerColor: AppColors.border,
);
