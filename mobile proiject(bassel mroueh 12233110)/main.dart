//bassel mroueh
//112233110
import 'package:flutter/material.dart';
import 'flashcard_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Language Flashcards',
      debugShowCheckedModeBanner: false,
      home: FlashcardScreen(),
    );
  }
}
