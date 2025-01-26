import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff65558f),
      surfaceTint: Color(0xff65558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffe9ddff),
      onPrimaryContainer: Color(0xff4d3d75),
      secondary: Color(0xff715188),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff2daff),
      onSecondaryContainer: Color(0xff583a6f),
      tertiary: Color(0xff5c5891),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe3dfff),
      onTertiaryContainer: Color(0xff444078),
      error: Color(0xff904b40),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad4),
      onErrorContainer: Color(0xff73342a),
      surface: Color(0xfffdf7ff),
      onSurface: Color(0xff1d1b20),
      onSurfaceVariant: Color(0xff49454e),
      outline: Color(0xff7a757f),
      outlineVariant: Color(0xffcac4cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffd0bdfe),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff210f47),
      primaryFixedDim: Color(0xffd0bdfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xfff2daff),
      onSecondaryFixed: Color(0xff2a0c40),
      secondaryFixedDim: Color(0xffdeb8f7),
      onSecondaryFixedVariant: Color(0xff583a6f),
      tertiaryFixed: Color(0xffe3dfff),
      onTertiaryFixed: Color(0xff18124a),
      tertiaryFixedDim: Color(0xffc5c0ff),
      onTertiaryFixedVariant: Color(0xff444078),
      surfaceDim: Color(0xffded8e0),
      surfaceBright: Color(0xfffdf7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f2fa),
      surfaceContainer: Color(0xfff2ecf4),
      surfaceContainerHigh: Color(0xffece6ee),
      surfaceContainerHighest: Color(0xffe6e0e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd0bdfe),
      surfaceTint: Color(0xffd0bdfe),
      onPrimary: Color(0xff36265d),
      primaryContainer: Color(0xff4d3d75),
      onPrimaryContainer: Color(0xffe9ddff),
      secondary: Color(0xffdeb8f7),
      onSecondary: Color(0xff402357),
      secondaryContainer: Color(0xff583a6f),
      onSecondaryContainer: Color(0xfff2daff),
      tertiary: Color(0xffc5c0ff),
      onTertiary: Color(0xff2d2960),
      tertiaryContainer: Color(0xff444078),
      onTertiaryContainer: Color(0xffe3dfff),
      error: Color(0xffffb4a8),
      onError: Color(0xff561e16),
      errorContainer: Color(0xff73342a),
      onErrorContainer: Color(0xffffdad4),
      surface: Color(0xff141218),
      onSurface: Color(0xffe6e0e9),
      onSurfaceVariant: Color(0xffcac4cf),
      outline: Color(0xff948f99),
      outlineVariant: Color(0xff49454e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e0e9),
      inversePrimary: Color(0xff65558f),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff210f47),
      primaryFixedDim: Color(0xffd0bdfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xfff2daff),
      onSecondaryFixed: Color(0xff2a0c40),
      secondaryFixedDim: Color(0xffdeb8f7),
      onSecondaryFixedVariant: Color(0xff583a6f),
      tertiaryFixed: Color(0xffe3dfff),
      onTertiaryFixed: Color(0xff18124a),
      tertiaryFixedDim: Color(0xffc5c0ff),
      onTertiaryFixedVariant: Color(0xff444078),
      surfaceDim: Color(0xff141218),
      surfaceBright: Color(0xff3b383e),
      surfaceContainerLowest: Color(0xff0f0d13),
      surfaceContainerLow: Color(0xff1d1b20),
      surfaceContainer: Color(0xff211f24),
      surfaceContainerHigh: Color(0xff2b292f),
      surfaceContainerHighest: Color(0xff36343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: colorScheme.onSurface,
          selectedIconTheme: IconThemeData(color: colorScheme.primary),
          unselectedIconTheme: IconThemeData(color: colorScheme.secondary),
        ),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: colorScheme.tertiary),
        dialogTheme: DialogTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.inversePrimary,
          foregroundColor: colorScheme.onSurface,
        ),
        chipTheme: const ChipThemeData(
          showCheckmark: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: WidgetStateProperty.all<Color>(
              colorScheme.inversePrimary,
            ),
            foregroundColor: WidgetStateProperty.all<Color>(
              colorScheme.onSurface,
            ),
            textStyle: WidgetStateProperty.all<TextStyle>(
              TextStyle(
                color: colorScheme.secondary,
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        cardTheme: CardTheme(surfaceTintColor: colorScheme.onSurface),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primaryContainer,
          centerTitle: true,
        ),
        iconTheme: IconThemeData(
          color: colorScheme.onSurface,
        ),
      );
}
