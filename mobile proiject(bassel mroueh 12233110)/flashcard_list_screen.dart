//bassel mroueh
//112233110
import 'package:flutter/material.dart';
import 'flashcards.dart';

class FlashcardListScreen extends StatelessWidget {
  const FlashcardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Flashcards'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: flashcards.isEmpty
          ? const Center(child: Text('No flashcards available'))
          : ListView.builder(
        itemCount: flashcards.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(flashcards[index]['word'] ?? ''),
            subtitle: Text(flashcards[index]['translation'] ?? ''),
          );
        },
      ),
    );
  }
}
