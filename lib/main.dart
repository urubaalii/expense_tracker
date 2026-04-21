import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart'; 
import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
  );

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor:const Color.fromARGB(255, 5, 99, 125),);


void main() {
  runApp(
    MaterialApp(
    theme: ThemeData( //define theme of app: color, text, app bar, card, button
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.normal,
          color: kColorScheme.onSecondaryContainer,
          fontSize: 20
        ),
      ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primaryContainer),
    )
    ),


//dark mode:
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kColorScheme,
    cardTheme: CardThemeData(
      color: kColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ), 
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kDarkColorScheme.primaryContainer,
        foregroundColor: kDarkColorScheme.onPrimaryContainer
    ),
    )
    ),

themeMode: ThemeMode.system,
    home: Expenses(),
  )
  );
}