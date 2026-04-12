import 'package:ai_journal/models/journal_entry.dart';
import 'package:flutter/material.dart';

class EntryDetailScreen extends StatelessWidget {
  JournalEntry entry;
  EntryDetailScreen({super.key, required this.entry});
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  String getmonth(int month) {
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Entry Detail")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // SizedBox(width: 24),
                Row(
                  children: [
                    Text(getmonth(entry.date.month)),
                    SizedBox(width: 3),
                    Text(entry.date.day.toString()),
                    SizedBox(width: 3),
                    Text(entry.date.year.toString()),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(entry.body),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
