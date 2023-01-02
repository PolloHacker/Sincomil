import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
ThemeData light = FlexThemeData.light(
  scheme: FlexScheme.jungle,
  surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
  blendLevel: 9,
  swapColors: true,
  subThemesData: const FlexSubThemesData(
    fabUseShape: true,
    fabAlwaysCircular: true,
    appBarBackgroundSchemeColor: SchemeColor.primary,
    bottomNavigationBarShowUnselectedLabels: false,
    navigationBarLabelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.quicksand().fontFamily,
);
ThemeData dark = FlexThemeData.dark(
  scheme: FlexScheme.jungle,
  surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
  blendLevel: 15,
  subThemesData: const FlexSubThemesData(
    fabUseShape: true,
    fabAlwaysCircular: true,
    appBarBackgroundSchemeColor: SchemeColor.tertiaryContainer,
    bottomNavigationBarShowUnselectedLabels: false,
    navigationBarLabelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.quicksand().fontFamily,
);
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
