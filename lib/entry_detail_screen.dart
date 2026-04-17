import 'package:ai_journal/add_entery_screen.dart';
import 'package:ai_journal/models/journal_entry.dart';
import 'package:ai_journal/providers/journal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// there is a proble that when we update the entry and press the edit entry button it gos back to the entry deail page nut the entry in the entry detaile page is not the updated verstion
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
      appBar: AppBar(
        title: const Text("Entry Detail"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEnteryScreen(entryToEdit: entry),
              ),
            ),
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Entry ?"),
                  content: const Text('This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<JournalProvider>(
                          context,
                          listen: false,
                        ).deleteEntry(entry.id);
                        Navigator.pop(context, true);

                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },

            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
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
