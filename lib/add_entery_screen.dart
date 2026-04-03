import 'package:ai_journal/providers/journal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEnteryScreen extends StatefulWidget {
  const AddEnteryScreen({super.key});

  @override
  State<AddEnteryScreen> createState() => _AddEnteryScreenState();
}

class _AddEnteryScreenState extends State<AddEnteryScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Entry")),
      body: Padding(
        // added for test purpuse
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(
                labelText: "Write your thoughts...",
                alignLabelWithHint: true,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              textAlignVertical: TextAlignVertical.top,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Here you would typically save the entry to a database or state management solution
                // For now, we'll just pop back to the previous screen
                // print(titleController.text);
                // print(bodyController.text);
                Provider.of<JournalProvider>(
                  context,
                  listen: false,
                ).addEntery(titleController.text, bodyController.text);
                Navigator.pop(context);
              },
              child: Text("Save Entry"),
            ),
          ],
        ),
      ),
    );
  }
}
