import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFF48FB1);
  static const Color secondaryColor = Color(0xFF90CAF9);

  static final ColorScheme _colorScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
  ).copyWith(secondary: secondaryColor);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.itimTextTheme().apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
      colorScheme: _colorScheme,

      timePickerTheme: TimePickerThemeData(
        helpTextStyle: TextStyle(color: primaryColor),
        confirmButtonStyle: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(primaryColor),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        cancelButtonStyle: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(primaryColor),
        ),
        dialTextColor: primaryColor,
        dialHandColor: primaryColor.withAlpha((255.0 * 0.2).round()),
        hourMinuteColor: primaryColor.withAlpha((255.0 * 0.2).round()),
        hourMinuteTextColor: primaryColor,
        dayPeriodColor: primaryColor.withAlpha((255.0 * 0.2).round()),
        dayPeriodTextColor: primaryColor,
        dayPeriodBorderSide: BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      datePickerTheme: DatePickerThemeData(
        rangePickerHeaderForegroundColor: primaryColor,
        yearForegroundColor: WidgetStatePropertyAll(
          primaryColor.withAlpha((255.0 * 0.7).round()),
        ),
        headerForegroundColor: primaryColor.withAlpha((255.0 * 0.7).round()),
        weekdayStyle: TextStyle(
          color: primaryColor.withAlpha((255.0 * 0.7).round()),
        ),
        dividerColor: primaryColor.withAlpha((255.0 * 0.1).round()),
        dayOverlayColor: WidgetStatePropertyAll(
          primaryColor.withAlpha((255.0 * 0.1).round()),
        ),
        dayBackgroundColor: WidgetStatePropertyAll(
          primaryColor.withAlpha((255.0 * 0.1).round()),
        ),
        dayForegroundColor: const WidgetStatePropertyAll(Colors.black87),
        todayBackgroundColor: WidgetStatePropertyAll(primaryColor),
        todayForegroundColor: const WidgetStatePropertyAll(Colors.white),
        confirmButtonStyle: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(primaryColor),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        cancelButtonStyle: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(primaryColor),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(secondaryColor),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      scaffoldBackgroundColor: Colors.white,

      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            primaryColor.withAlpha((255.0 * 0.1).round()),
          ),
          iconColor: WidgetStatePropertyAll(primaryColor),
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        surfaceTintColor: primaryColor,
        backgroundColor: Colors.white,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        backgroundColor: primaryColor.withAlpha((255.0 * 0.1).round()),
        foregroundColor: primaryColor,
        iconSize: 32,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: secondaryColor.withAlpha((255.0 * 0.1).round()),
        selectedColor: secondaryColor.withAlpha((255.0 * 0.2).round()),
        elevation: 0,
        pressElevation: 0,
        labelStyle: TextStyle(color: secondaryColor),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        checkmarkColor: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: secondaryColor),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        iconColor: primaryColor,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black12, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black12, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
