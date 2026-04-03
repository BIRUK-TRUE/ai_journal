import 'package:ai_journal/add_entery_screen.dart';
import 'package:ai_journal/entry_detail_screen.dart';
import 'package:ai_journal/providers/journal_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var entryList = Provider.of<JournalProvider>(context).entries;
    return Scaffold(
      appBar: AppBar(title: const Text("My AI Journal")),
      body: ListView.builder(
        itemCount: entryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EntryDetailScreen(),
                    ),
                  );
                },
                leading: Icon(Icons.book),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text(entryList[index].title),
                subtitle: Text(entryList[index].body),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEnteryScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
