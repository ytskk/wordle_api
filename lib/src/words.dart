import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:wordle_api/wordle_api.dart';

List<LetterPositionState> compareWords(
  String chosen,
  String target,
) {
  assert(
    chosen.length == target.length,
    'chosen and target must be the same length',
  );

  final targetLetterCounts = <String>{};

  // fill the set with unique letters from target
  for (final letter in target.split('')) {
    if (!targetLetterCounts.contains(letter)) {
      targetLetterCounts.add(letter);
    }
  }

  final result = List<LetterPositionState>.generate(
    target.length,
    (index) => LetterPositionState.absent,
  );

  // fill with exact letter and position matches
  for (var i = 0; i < chosen.length; i += 1) {
    if (chosen[i] == target[i]) {
      result[i] = LetterPositionState.correct;
    }
  }

  // fill with letter matches
  for (var i = 0; i < chosen.length; i += 1) {
    if (chosen[i] != target[i] && targetLetterCounts.contains(chosen[i])) {
      result[i] = LetterPositionState.present;
    }
  }

  return result;
}

/// Picks a random word from the `words.json` list.
Future<String> getRandomWord() async {
  final wordsJson = await getWordsJson();

  final randomWordIndex = Random().nextInt(wordsJson.length);
  final randomWord = wordsJson[randomWordIndex];

  return randomWord;
}

Future<List<String>> getWordsJson() async {
  final file = File('lib/src/data/words.json');
  final content = await file.readAsString();
  final json = jsonDecode(content) as List;

  return json.cast<String>();
}
