import 'package:flutter/foundation.dart';
import '../models/journal_entry.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class JournalProvider extends ChangeNotifier {
  JournalProvider() {
    loadEntries();
  }
  List<JournalEntry> _entries = [];

  List<JournalEntry> get entries => _entries;
  void addEntery(String title, String body) {
    var newEntry = JournalEntry(title: title, body: body);
    _entries.add(newEntry);
    _saveEnteries();
    notifyListeners();
  }

  Future<void> _saveEnteries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> entryList = _entries
        .map((entry) => jsonEncode(entry.toMap()))
        .toList();
    await prefs.setStringList('journal_entries', entryList);
  }

  Future<void> loadEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? entryList = prefs.getStringList('journal_entries');
    if (entryList == null) {
      return;
    }
    _entries = entryList
        .map((entry) => JournalEntry.fromMap(jsonDecode(entry)))
        .toList();
    notifyListeners();
  }

  void updateEntry(String id, String title, String body) {
    JournalEntry targetEntrey = _entries.firstWhere(
      (entery) => entery.id == id,
    );
    targetEntrey.title = title;
    targetEntrey.body = body;
    _saveEnteries();
    notifyListeners();
  }

  void deleteEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    _saveEnteries();
    notifyListeners();
  }

  JournalEntry getEntryById(String id) {
    return _entries.firstWhere((entry) => entry.id == id);
  }
}
