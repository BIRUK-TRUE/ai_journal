// import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';
import 'package:ai_journal/api_config.dart';
import 'package:http/http.dart' as http;

class AiService {
  //  String journalText;
  // AiService({this.journalText});
  Future<String> getJournalReflection(String journalText) async {
    var uri = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

    String prompt =
        'You are a compassionate journal companion. The user has written the following journal entry. Please provide a thoughtful, empathetic reflection in 2-3 sentences that acknowledges their feelings and offers a positive insight. Journal entry: $journalText';

    Map<String, dynamic> body = {
      "model": "llama-3.3-70b-versatile",
      "messages": [
        {"role": "user", "content": prompt},
      ],
    };

    // final model = GenerativeModel(
    //   model: 'gemini-pro',
    //   apiKey: ApiConfig.geminiApiKey,
    //   requestOptions: RequestOptions(apiVersion: 'v1'),
    // );

    try {
      // var response = await model.generateContent([Content.text(prompt)]);
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ApiConfig.groqApiKey}',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else if (response.statusCode == 429) {
        return 'AI is busy right now. Please try again in a moment.';
      } else {
        return 'Error: ${response.statusCode} - ${response.body}';
      }

      // return response.text ?? "No Reflection avilable";
    } catch (e) {
      return 'Could not get reflection: ${e.toString()}';
    }
  }
}
