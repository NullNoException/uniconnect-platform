import 'package:control_panel/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light theme colors
  static const Color _lightPrimaryColor = Color(0xFF2563EB);
  static const Color _lightPrimaryVariantColor = Color(0xFF1E40AF);
  static const Color _lightSecondaryColor = Color(0xFF14B8A6);
  static const Color _lightBackgroundColor = Color(0xFFF9FAFB);
  static const Color _lightSurfaceColor = Colors.white;
  static const Color _lightErrorColor = Color(0xFFDC2626);
  static const Color _lightOnPrimaryColor = Colors.white;
  static const Color _lightTextColor = Color(0xFF1F2937);
  static const Color _lightCardColor = Colors.white;
  static const Color _lightDividerColor = Color(0xFFE5E7EB);

  // Dark theme colors
  static const Color _darkPrimaryColor = Color(0xFF3B82F6);
  static const Color _darkPrimaryVariantColor = Color(0xFF2563EB);
  static const Color _darkSecondaryColor = Color(0xFF0D9488);
  static const Color _darkBackgroundColor = Color(0xFF111827);
  static const Color _darkSurfaceColor = Color(0xFF1F2937);
  static const Color _darkErrorColor = Color(0xFFEF4444);
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkTextColor = Color(0xFFF9FAFB);
  static const Color _darkCardColor = Color(0xFF1F2937);
  static const Color _darkDividerColor = Color(0xFF4B5563);

  // Additional colors
  static const Color successColor = Color(0xFF22C55E);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color infoColor = Color(0xFF3B82F6);

  // Text styles
  static TextTheme _buildTextTheme(TextTheme base, Color textColor) {
    return base.copyWith(
      displayLarge: base.displayLarge!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displayMedium: base.displayMedium!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displaySmall: base.displaySmall!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineLarge: base.headlineLarge!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: base.headlineMedium!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: base.headlineSmall!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleLarge: base.titleLarge!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: base.titleMedium!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: base.bodyLarge!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      labelLarge: base.labelLarge!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      labelMedium: base.labelMedium!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      labelSmall: base.labelSmall!.copyWith(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }

  // Light theme
  static ThemeData lightTheme() {
    final ThemeData base = ThemeData.light();
    final ColorScheme colorScheme = const ColorScheme.light(
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      primaryContainer: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      surface: _lightSurfaceColor,
      error: _lightErrorColor,
      onSurface: _lightTextColor,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(base.textTheme, _lightTextColor),
      primaryColor: _lightPrimaryColor,
      scaffoldBackgroundColor: _lightBackgroundColor,
      cardColor: _lightCardColor,
      dividerColor: _lightDividerColor,
      canvasColor: _lightSurfaceColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: _lightSurfaceColor,
        foregroundColor: _lightTextColor,
        centerTitle: false,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _lightPrimaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: _lightOnPrimaryColor,
          backgroundColor: _lightPrimaryColor,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: const BorderSide(color: _lightPrimaryColor),
          foregroundColor: _lightPrimaryColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: _lightPrimaryColor,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _lightPrimaryColor,
        foregroundColor: _lightOnPrimaryColor,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _lightDividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _lightDividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _lightPrimaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _lightErrorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: _lightPrimaryColor,
        unselectedLabelColor: _lightTextColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: _lightPrimaryColor, width: 2),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: _lightTextColor.widgetStateProperty(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: const TextStyle(color: Colors.white),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _lightPrimaryColor;
          }
          return Colors.transparent;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _lightPrimaryColor;
          }
          return _lightTextColor.widgetStateProperty(0.6);
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _lightPrimaryColor;
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _lightPrimaryColor.widgetStateProperty(0.5);
          }
          return Colors.grey.widgetStateProperty(0.5);
        }),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _lightSurfaceColor,
        selectedItemColor: _lightPrimaryColor,
        unselectedItemColor: _lightTextColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dataTableTheme: const DataTableThemeData(
        headingRowColor: WidgetStatePropertyAll(_lightBackgroundColor),
        dataRowColor: WidgetStatePropertyAll(Colors.white),
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: _lightTextColor,
        ),
        dataTextStyle: TextStyle(color: _lightTextColor),
        dividerThickness: 1,
      ),
    );
  }

  // Dark theme
  static ThemeData darkTheme() {
    final ThemeData base = ThemeData.dark();
    final ColorScheme colorScheme = const ColorScheme.dark(
      primary: _darkPrimaryColor,
      onPrimary: _darkOnPrimaryColor,
      primaryContainer: _darkPrimaryVariantColor,
      secondary: _darkSecondaryColor,
      surface: _darkSurfaceColor,
      error: _darkErrorColor,
      onSurface: _darkTextColor,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(base.textTheme, _darkTextColor),
      primaryColor: _darkPrimaryColor,
      scaffoldBackgroundColor: _darkBackgroundColor,
      cardColor: _darkCardColor,
      dividerColor: _darkDividerColor,
      canvasColor: _darkSurfaceColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: _darkSurfaceColor,
        foregroundColor: _darkTextColor,
        centerTitle: false,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _darkPrimaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: _darkOnPrimaryColor,
          backgroundColor: _darkPrimaryColor,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: const BorderSide(color: _darkPrimaryColor),
          foregroundColor: _darkPrimaryColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: _darkPrimaryColor,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _darkPrimaryColor,
        foregroundColor: _darkOnPrimaryColor,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: _darkSurfaceColor,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _darkDividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _darkDividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _darkPrimaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _darkErrorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: _darkPrimaryColor,
        unselectedLabelColor: _darkTextColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: _darkPrimaryColor, width: 2),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: _darkTextColor.widgetStateProperty(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: const TextStyle(color: _darkSurfaceColor),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _darkPrimaryColor;
          }
          return Colors.transparent;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _darkPrimaryColor;
          }
          return _darkTextColor.widgetStateProperty(0.6);
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _darkPrimaryColor;
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _darkPrimaryColor.widgetStateProperty(0.5);
          }
          return Colors.grey.widgetStateProperty(0.5);
        }),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _darkSurfaceColor,
        selectedItemColor: _darkPrimaryColor,
        unselectedItemColor: _darkTextColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dataTableTheme: const DataTableThemeData(
        headingRowColor: WidgetStatePropertyAll(_darkSurfaceColor),
        dataRowColor: WidgetStatePropertyAll(_darkCardColor),
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: _darkTextColor,
        ),
        dataTextStyle: TextStyle(color: _darkTextColor),
        dividerThickness: 1,
      ),
    );
  }
}
