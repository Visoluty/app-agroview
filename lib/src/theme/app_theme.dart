import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores principais
  static const Color primaryGreen = Color(0xFF2D5016);
  static const Color secondaryGreen = Color(0xFF4A7C59);
  static const Color lightGreen = Color(0xFF6B7C54);
  static const Color accentGreen = Color(0xFF228B22);
  static const Color limeGreen = Color(0xFF9ACD32);
  
  // Cores de fundo
  static const Color backgroundColor = Color(0xFFF8F6F0);
  static const Color cardBackground = Colors.white;
  static const Color lightCardBackground = Color(0xFFF0F8E8);
  
  // Cores de texto
  static const Color primaryText = Color(0xFF2D5016);
  static const Color secondaryText = Color(0xFF5D4E37);
  static const Color lightText = Color(0xFF6B7C54);
  static const Color mutedText = Color(0xFF8A8A8A);
  
  // Cores de borda e divisores
  static const Color borderColor = Color(0xFFE8E5D8);
  static const Color lightBorder = Color(0xFFE8E6E0);
  static const Color dividerColor = Color(0xFFD4C5A9);
  
  // Cores de defeitos
  static const Color moldyColor = Color(0xFFCD853F);
  static const Color brokenColor = Color(0xFFD2691E);
  static const Color attackedColor = Color(0xFFB22222);
  static const Color impurityColor = Color(0xFF8B4513);
  
  // Cores de grãos
  static const Color soyColor = Color(0xFF4A7C59);
  static const Color cornColor = Color(0xFFD4A574);
  static const Color wheatColor = Color(0xFFB8860B);
  static const Color beanColor = Color(0xFF8B4513);
  
  // Cores de status
  static const Color successColor = Color(0xFF228B22);
  static const Color warningColor = Color(0xFFCD853F);
  static const Color errorColor = Color(0xFFDC3545);
  
  // Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        brightness: Brightness.light,
        primary: primaryGreen,
        secondary: secondaryGreen,
        surface: cardBackground,
        error: errorColor,
      ),
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      dividerTheme: _dividerTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: GoogleFonts.interTight(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryText,
      ),
      displayMedium: GoogleFonts.interTight(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryText,
      ),
      displaySmall: GoogleFonts.interTight(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryText,
      ),
      headlineLarge: GoogleFonts.interTight(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      headlineMedium: GoogleFonts.interTight(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      headlineSmall: GoogleFonts.interTight(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      titleLarge: GoogleFonts.interTight(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      titleMedium: GoogleFonts.interTight(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      titleSmall: GoogleFonts.interTight(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: primaryText,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: primaryText,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: lightText,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryText,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: primaryText,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: lightText,
      ),
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.interTight(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.interTight(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondaryGreen,
        side: const BorderSide(color: secondaryGreen, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.interTight(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryGreen,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dividerColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dividerColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: secondaryGreen, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: GoogleFonts.inter(
        fontSize: 16,
        color: mutedText,
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        color: lightText,
      ),
    );
  }

  static CardThemeData get _cardTheme {
    return CardThemeData(
      color: cardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: borderColor, width: 1),
      ),
      margin: const EdgeInsets.all(8),
    );
  }

  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: lightBorder,
      thickness: 1,
      space: 1,
    );
  }

  // Métodos utilitários para cores
  static Color getGrainColor(String grainType) {
    switch (grainType.toLowerCase()) {
      case 'soja':
        return soyColor;
      case 'milho':
        return cornColor;
      case 'trigo':
        return wheatColor;
      case 'feijão':
      case 'feijao':
        return beanColor;
      default:
        return secondaryGreen;
    }
  }

  static Color getDefectColor(String defectType) {
    switch (defectType.toLowerCase()) {
      case 'mofados':
        return moldyColor;
      case 'quebrados':
        return brokenColor;
      case 'atacados':
        return attackedColor;
      case 'impurezas':
        return impurityColor;
      default:
        return warningColor;
    }
  }

  static Color getQualityColor(double percentage) {
    if (percentage >= 90) return successColor;
    if (percentage >= 70) return warningColor;
    return errorColor;
  }

  static String getQualityText(double percentage) {
    if (percentage >= 90) return 'Excelente';
    if (percentage >= 80) return 'Muito Boa';
    if (percentage >= 70) return 'Boa';
    if (percentage >= 60) return 'Regular';
    return 'Ruim';
  }
}
