import 'package:flutter/material.dart';

final ThemeData customTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  // primarySwatch: Colors.blue,
  fontFamily: 'Nunito',
  textTheme: const TextTheme(
    // Display styles – typically for large headers or impactful text.
    displayLarge: TextStyle(
        fontSize: 48, fontWeight: FontWeight.w400, fontFamily: 'Nunito'),
    displayMedium: TextStyle(
        fontSize: 43, fontWeight: FontWeight.w600, fontFamily: 'Nunito'),
    displaySmall: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w400,
      fontFamily: 'Nunito',
    ),

    // Headline styles – for prominent headlines.
    headlineLarge: TextStyle(
        fontSize: 25, fontWeight: FontWeight.w400, fontFamily: 'Nunito'),
    headlineMedium: TextStyle(
        fontSize: 23, fontWeight: FontWeight.w400, fontFamily: 'Nunito'),
    headlineSmall: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w400, fontFamily: 'Nunito'),

    // Title styles – for titles and subheads.
    titleLarge: TextStyle(
        fontSize: 26, fontWeight: FontWeight.w700, fontFamily: 'Nunito'),
    titleMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'Nunito'),
    titleSmall: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Nunito'),

    // Body styles – for the main content.
    bodyLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Nunito'),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Nunito'),
    bodySmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Nunito'),

    // Label styles – for buttons and captions.
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Nunito'),
    labelMedium: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Nunito'),
    labelSmall: TextStyle(
        fontSize: 11, fontWeight: FontWeight.w500, fontFamily: 'Nunito'),
  ),
);
