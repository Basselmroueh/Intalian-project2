//bassel mroueh
//112233110
import 'package:flutter/material.dart';
import 'flashcards.dart';
import 'add_flashcard_dialog.dart';
import 'flashcard_list_screen.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int currentIndex = 0;
  bool isFlipped = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFlashcards().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void flipCard() {
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % flashcards.length;
      isFlipped = false;
    });
  }

  Future<void> addFlashcard(String word, String translation) async {
    await addFlashcardToDatabase(word, translation);
    setState(() {
      flashcards.add({'word': word, 'translation': translation});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Italian Language Flashcards', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FlashcardListScreen()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : flashcards.isEmpty
          ? const Center(child: Text('No flashcards available'))
          : Center(
        child: GestureDetector(
          onTap: flipCard,
          child: Card(
            elevation: 4,
            color: isFlipped ? Colors.purple : Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: const EdgeInsets.all(24),
              width: 300,
              height: 200,
              alignment: Alignment.center,
              child: Text(
                isFlipped ? flashcards[currentIndex]['translation'] ?? '' : flashcards[currentIndex]['word'] ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FloatingActionButton(
              heroTag: 'addFlashcard',
              onPressed: () => showAddFlashcardDialog(context, addFlashcard),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              tooltip: 'Add New Flashcard',
              child: const Icon(Icons.add),
            ),
          ),
          FloatingActionButton.extended(
            heroTag: 'nextFlashcard',
            onPressed: nextCard,
            label: const Text('Next Word'),
            icon: const Icon(Icons.navigate_next),
            backgroundColor:Colors.red.shade400 ,
            foregroundColor: Colors.white54,
          ),
        ],
      ),
    );
  }
}
