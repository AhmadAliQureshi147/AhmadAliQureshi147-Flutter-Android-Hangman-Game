import 'dart:math';
import 'package:english_words/english_words.dart';

class Game {
  late String secretWord;
  late List<String> displayWordList;
  List<String> wrongLettersGuessed = [];
  late String displayWord;

  Game() {
    generateRandomWord();
    initDisplayWordList();
  }

  void generateRandomWord() {
    int n;
    do {
      n = Random.secure().nextInt(all.length);
    } while (all[n].length <= 5 || all[n].length > 9);
    secretWord = all[n].toUpperCase();
  }

  void initDisplayWordList() {
    displayWordList = List.filled(secretWord.length, '_ ');
    for (int i = 0; i < (secretWord.length / 3).floor(); i++) {
      int n = Random.secure().nextInt(secretWord.length);
      if (displayWordList[n] == '_ ')
        replaceAll(secretWord[n]);
      else
        i++;
    }
    displayWord = displayWordList.join();
  }

  void guessLetter(String letter) {
    int n = secretWord.indexOf(letter);
    if (n >= 0) {
      replaceAll(letter);
      displayWord = displayWordList.join();
    } else {
      wrongLettersGuessed.add(letter);
    }
  }

  void replaceAll(String letter) {
    for (int i = 0; i < secretWord.length; i++) {
      if (secretWord[i] == letter) {
        displayWordList[i] = letter;
      }
    }
  }

  bool isWordGuessed() {
    return displayWord.compareTo(secretWord) == 0;
  }

  bool hasLost() {
    return wrongLettersGuessed.length >= 6;
  }
}
