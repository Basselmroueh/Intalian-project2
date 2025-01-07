//bassel mroueh
//112233110
import 'package:http/http.dart' as http;
import 'dart:convert';

final String apiUrl = 'http://10.0.2.2/flashcards_api';

List<Map<String, String>> flashcards = [];

Future<void> fetchFlashcards() async {
  try {
    final response = await http.get(Uri.parse('$apiUrl/get_flashcards.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      flashcards = data.map<Map<String, String>>((item) {
        return {
          'word': item['word'] as String,
          'translation': item['translation'] as String,
        };
      }).toList();
    } else {
      throw Exception('Failed to load flashcards');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> addFlashcardToDatabase(String word, String translation) async {
  try {
    final response = await http.post(
      Uri.parse('$apiUrl/add_flashcard.php'),
      body: {'word': word, 'translation': translation},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add flashcard');
    }
  } catch (e) {
    print('Error: $e');
  }
}
