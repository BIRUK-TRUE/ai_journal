// class JournalEntry {
//   // the value must be fixed or assigned at the moment the object is created
//   final String id;
//   String title;
//   String body;
//   final DateTime date;
class JournalEntry {
  final String id;
  String title;
  String body;
  final DateTime date;

  // Step 1: Private constructor (notice the underscore _)
  JournalEntry._internal({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  // Step 2: Factory constructor
  factory JournalEntry({required String title, required String body}) {
    // NOW you can create variables here!
    var currentDate = DateTime.now(); // What goes here?

    return JournalEntry._internal(
      id: currentDate.microsecondsSinceEpoch.toString(),
      title: title,
      body: body,
      date: currentDate,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'date': date.toIso8601String(),
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry._internal(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      date: DateTime.parse(map['date']),
    );
  }
}
