//bassel mroueh
//112233110
import 'package:flutter/material.dart';

void showAddFlashcardDialog(BuildContext context, Function(String, String) addFlashcard) {
  String word = '';
  String translation = '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add New Flashcard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Word'),
              onChanged: (value) {
                word = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Translation'),
              onChanged: (value) {
                translation = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (word.isNotEmpty && translation.isNotEmpty) {
                await addFlashcard(word, translation);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
