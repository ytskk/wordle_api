// ignore_for_file: avoid_print
import 'package:wordle_api/wordle_api.dart';

Future<void> main() async {
  const gameService = WordleGameFactory();
  final board = gameService.buildBoard();
  final keyboard = gameService.buildKeyboard();

  const guessedWord = 'hello';
  const targetWord = 'dream';

  final comparison = compareWords(guessedWord, targetWord);

  const boardRow = 0;
  final newBoard = gameService.updateBoard(
    oldBoard: board,
    boardRow: boardRow,
    guessedWord: guessedWord,
    result: comparison,
  );

  print('Board:');
  print(newBoard[boardRow]);

  final newKeyboard = gameService.updateKeyboard(
    oldKeyboard: keyboard,
    guessedWord: guessedWord,
    result: comparison,
  );

  print('Keyboard:');
  print(newKeyboard);

  final randomWord = await getRandomWord();
  print('Random word: $randomWord');
}
