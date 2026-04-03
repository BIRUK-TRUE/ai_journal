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
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    ),
  );
}
