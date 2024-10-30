import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5754a7),
      surfaceTint: Color(0xff5754a7),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffaeabff),
      onPrimaryContainer: Color(0xff1f196e),
      secondary: Color(0xff5c5b7d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdedbff),
      onSecondaryContainer: Color(0xff444263),
      tertiary: Color(0xff5e5b7d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9e99bf),
      onTertiaryContainer: Color(0xff0e0b2a),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffcf8ff),
      onSurface: Color(0xff1c1b20),
      onSurfaceVariant: Color(0xff474551),
      outline: Color(0xff777682),
      outlineVariant: Color(0xffc8c5d3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313036),
      inversePrimary: Color(0xffc3c0ff),
      primaryFixed: Color(0xffe3dfff),
      onPrimaryFixed: Color(0xff110562),
      primaryFixedDim: Color(0xffc3c0ff),
      onPrimaryFixedVariant: Color(0xff3f3c8e),
      secondaryFixed: Color(0xffe3dfff),
      onSecondaryFixed: Color(0xff191836),
      secondaryFixedDim: Color(0xffc5c3ea),
      onSecondaryFixedVariant: Color(0xff454364),
      tertiaryFixed: Color(0xffe4dfff),
      onTertiaryFixed: Color(0xff1a1836),
      tertiaryFixedDim: Color(0xffc7c2ea),
      onTertiaryFixedVariant: Color(0xff464364),
      surfaceDim: Color(0xffdcd9e0),
      surfaceBright: Color(0xfffcf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f2fa),
      surfaceContainer: Color(0xfff0ecf4),
      surfaceContainerHigh: Color(0xffeae7ef),
      surfaceContainerHighest: Color(0xffe5e1e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc8c5ff),
      surfaceTint: Color(0xffc3c0ff),
      onPrimary: Color(0xff282376),
      primaryContainer: Color(0xff9c99f1),
      onPrimaryContainer: Color(0xff0c005b),
      secondary: Color(0xffc5c3ea),
      onSecondary: Color(0xff2e2d4c),
      secondaryContainer: Color(0xff3b3a5a),
      onSecondaryContainer: Color(0xffcfccf4),
      tertiary: Color(0xffc7c2ea),
      onTertiary: Color(0xff2f2d4c),
      tertiaryContainer: Color(0xff747194),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff131318),
      onSurface: Color(0xffe5e1e9),
      onSurfaceVariant: Color(0xffc8c5d3),
      outline: Color(0xff918f9c),
      outlineVariant: Color(0xff474551),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e1e9),
      inversePrimary: Color(0xff5754a7),
      primaryFixed: Color(0xffe3dfff),
      onPrimaryFixed: Color(0xff110562),
      primaryFixedDim: Color(0xffc3c0ff),
      onPrimaryFixedVariant: Color(0xff3f3c8e),
      secondaryFixed: Color(0xffe3dfff),
      onSecondaryFixed: Color(0xff191836),
      secondaryFixedDim: Color(0xffc5c3ea),
      onSecondaryFixedVariant: Color(0xff454364),
      tertiaryFixed: Color(0xffe4dfff),
      onTertiaryFixed: Color(0xff1a1836),
      tertiaryFixedDim: Color(0xffc7c2ea),
      onTertiaryFixedVariant: Color(0xff464364),
      surfaceDim: Color(0xff131318),
      surfaceBright: Color(0xff39383e),
      surfaceContainerLowest: Color(0xff0e0e13),
      surfaceContainerLow: Color(0xff1c1b20),
      surfaceContainer: Color(0xff201f25),
      surfaceContainerHigh: Color(0xff2a292f),
      surfaceContainerHighest: Color(0xff35343a),
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
