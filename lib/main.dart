import 'package:flutter/material.dart';
import 'package:ai_journal/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:ai_journal/providers/journal_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => JournalProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
        home: HomeScreen(),
      ),
    ),
  );
}

// there is a problem the saredprefernce is not working when i run the app  as desctop app but whenit is run as android app it works what is the proble. answore : The issue you're encountering with SharedPreferences not working in a desktop app is likely due to the fact that SharedPreferences is primarily designed for mobile platforms (Android and iOS) and may not be fully supported or may have limitations when used in desktop applications.
