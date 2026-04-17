import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ai_journal/api_config.dart';

class AiService {
  //  String journalText;
  // AiService({this.journalText});
  Future<String> getJournalReflection(String journalText) async {
    String prompt =
        'You are a compassionate journal companion. The user has written the following journal entry. Please provide a thoughtful, empathetic reflection in 2-3 sentences that acknowledges their feelings and offers a positive insight. Journal entry: $journalText';
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: ApiConfig.geminiApiKey,
    );
    try {
      var response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? "No Reflection avilable";
    } catch (e) {
      return 'Could not get reflection: ${e.toString()}';
    }
  }
}
