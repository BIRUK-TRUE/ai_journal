import 'package:ai_journal/add_entery_screen.dart';
import 'package:ai_journal/entry_detail_screen.dart';
import 'package:ai_journal/providers/journal_provider.dart';
import 'package:ai_journal/utils/date_formatter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  //  To run a method when a screen first appears, you typically use a lifecycle method called initState() which only exists in StatefulWidget. Since HomeScreen is a StatelessWidget, it does not have the initState() method. If you want to run a method when the HomeScreen first appears, you would need to convert it to a StatefulWidget and then implement the initState() method to call your desired method when the screen is initialized. but in this case we can call the loadEntries() method in the constructor of the JournalProvider, so it will be called when the provider is created and the entries will be loaded when the HomeScreen is first displayed.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // why it can be final it can change so final is not suttable for this cass? answore: The `entryList` variable is declared as `final` because it is assigned a value only once, which is the list of journal entries obtained from the `JournalProvider`. Even though the contents of the list can change (entries can be added or removed), the reference to the list itself does not change after it is assigned. Therefore, it is appropriate to declare it as `final` since we are not reassigning the variable to a different list, but rather modifying the contents of the existing list.
    final entryList = Provider.of<JournalProvider>(context).entries;
    // context.watch<JournalProvider>().entries; // this is the same as above but with a different syntax in this case listen:true
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.auto_stories_rounded),
            SizedBox(width: 8),
            const Text(
              "My AI Journal",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: entryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                isThreeLine: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EntryDetailScreen(entryId: entryList[index].id),
                    ),
                  );
                },
                leading: Icon(Icons.book),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text(entryList[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(getmonth(entryList[index].date.month)),
                        SizedBox(width: 3),
                        Text(entryList[index].date.day.toString()),
                        SizedBox(width: 3),
                        Text(entryList[index].date.year.toString()),
                      ],
                    ),
                    Text(
                      entryList[index].body.length > 50
                          ? "${entryList[index].body.substring(0, 51)}..."
                          : entryList[index].body,
                    ),
                    // //////////////////////////
                    Center(child: Column(Chi)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEnteryScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
