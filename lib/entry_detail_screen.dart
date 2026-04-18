import 'package:ai_journal/add_entery_screen.dart';
// import 'package:ai_journal/models/journal_entry.dart';
import 'package:ai_journal/providers/journal_provider.dart';
import 'package:ai_journal/services/ai_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_journal/utils/date_formatter.dart';

// there is a proble that when we update the entry and press the edit entry button it gos back to the entry deail page nut the entry in the entry detaile page is not the updated verstion
class EntryDetailScreen extends StatefulWidget {
  String entryId;
  EntryDetailScreen({super.key, required this.entryId});

  @override
  State<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends State<EntryDetailScreen> {
  String? _reflectionText;
  bool _isLoading = false;

  void _getReflection() async {
    setState(() {
      _isLoading = true;
    });
    AiService aiService = AiService();
    final provider = Provider.of<JournalProvider>(context, listen: false);
    String response = await aiService.getJournalReflection(
      provider.getEntryById(widget.entryId).body,
    );
    setState(() {
      _reflectionText = response;
      _isLoading = false;
    });
    // print(_reflectionText);
  }

  // String getmonth(int month) {
  //   return months[month - 1];
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<JournalProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entry Detail"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEnteryScreen(
                  entryToEdit: provider.getEntryById(widget.entryId),
                ),
              ),
            ),
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
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
                        ).deleteEntry(widget.entryId);
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.getEntryById(widget.entryId).title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(width: 24),
                  Row(
                    children: [
                      Text(
                        getmonth(
                          provider.getEntryById(widget.entryId).date.month,
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        provider
                            .getEntryById(widget.entryId)
                            .date
                            .day
                            .toString(),
                      ),
                      SizedBox(width: 3),
                      Text(
                        provider
                            .getEntryById(widget.entryId)
                            .date
                            .year
                            .toString(),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(provider.getEntryById(widget.entryId).body),
              SizedBox(height: 24),
              Text(
                "AI Reflection",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _getReflection,
                        child: Text("GetAI Reflection"),
                      ),
                      SizedBox(height: 12),
                      _isLoading
                          ? CircularProgressIndicator()
                          : _reflectionText != null
                          ? Container(
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _reflectionText!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  height: 1.5,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                                ),
                              ),
                            )
                          : SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
