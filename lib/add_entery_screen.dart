import 'package:ai_journal/models/journal_entry.dart';
import 'package:ai_journal/providers/journal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// what is the difference b/n !. and ?.
class AddEnteryScreen extends StatefulWidget {
  JournalEntry? entryToEdit;
  AddEnteryScreen({super.key, entryToEdit});

  @override
  State<AddEnteryScreen> createState() => _AddEnteryScreenState();
}

class _AddEnteryScreenState extends State<AddEnteryScreen> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  @override
  initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.entryToEdit == null ? '' : widget.entryToEdit!.title,
    );
    bodyController = TextEditingController(
      text: widget.entryToEdit == null ? '' : widget.entryToEdit!.body,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.entryToEdit == null
            ? const Text("Edit Entry")
            : const Text("New Entry"),
      ),
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
              // what is the use of this maxLines: 8, textAlignVertical: TextAlignVertical.top, in the textfield? answore: The `maxLines: 8` property allows the TextField to expand vertically up to 8 lines of text, providing more space for the user to write their thoughts. The `textAlignVertical: TextAlignVertical.top` property ensures that the text starts from the top of the TextField, which is especially useful when the TextField is multiline, as it prevents the text from being centered vertically and instead aligns it to the top for a more natural writing experience.
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
