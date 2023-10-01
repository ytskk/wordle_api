import 'package:wordle_api/wordle_api.dart';

typedef BoardScheme = List<List<LetterStateWithKey>>;

typedef KeyboardScheme = List<List<LetterStateWithKey>>;

class WordleGameFactory {
  const WordleGameFactory({
    this.triesCount = defaultTriesCount,
    this.wordLength = defaultWordLength,
  });

  final int triesCount;
  final int wordLength;

  static const int defaultTriesCount = 6;
  static const int defaultWordLength = 5;

  static const List<List<KeyboardKeyType>> keyboardScheme = [
    [
      KeyboardKeyTypeLetter('q'),
      KeyboardKeyTypeLetter('w'),
      KeyboardKeyTypeLetter('e'),
      KeyboardKeyTypeLetter('r'),
      KeyboardKeyTypeLetter('t'),
      KeyboardKeyTypeLetter('y'),
      KeyboardKeyTypeLetter('u'),
      KeyboardKeyTypeLetter('i'),
      KeyboardKeyTypeLetter('o'),
      KeyboardKeyTypeLetter('p'),
    ],
    [
      KeyboardKeyTypeLetter('a'),
      KeyboardKeyTypeLetter('s'),
      KeyboardKeyTypeLetter('d'),
      KeyboardKeyTypeLetter('f'),
      KeyboardKeyTypeLetter('g'),
      KeyboardKeyTypeLetter('h'),
      KeyboardKeyTypeLetter('j'),
      KeyboardKeyTypeLetter('k'),
      KeyboardKeyTypeLetter('l'),
    ],
    [
      KeyboardKeyTypeEnter(),
      KeyboardKeyTypeLetter('z'),
      KeyboardKeyTypeLetter('x'),
      KeyboardKeyTypeLetter('c'),
      KeyboardKeyTypeLetter('v'),
      KeyboardKeyTypeLetter('b'),
      KeyboardKeyTypeLetter('n'),
      KeyboardKeyTypeLetter('m'),
      KeyboardKeyTypeDelete(),
    ],
  ];

  BoardScheme buildBoard() {
    final board = <List<LetterStateWithKey>>[];

    for (var i = 0; i < triesCount; i += 1) {
      final boardRow = <LetterStateWithKey>[];

      for (var j = 0; j < wordLength; j += 1) {
        const value = LetterStateWithKey.empty();
        boardRow.add(value);
      }

      board.add(boardRow);
    }

    return board;
  }

  BoardScheme updateBoard({
    required BoardScheme oldBoard,
    required int boardRow,
    required String guessedWord,
    required List<LetterPositionState> result,
  }) {
    final newBoard = [
      ...oldBoard,
    ];

    final newBoardRow = [
      ...oldBoard[boardRow],
    ];

    for (var i = 0; i < guessedWord.length; i += 1) {
      final letter = guessedWord[i];
      final letterState = result[i];

      newBoardRow[i] = LetterStateWithKey(
        state: letterState,
        key: KeyboardKeyTypeLetter(letter),
      );
    }

    newBoard[boardRow] = newBoardRow;

    return newBoard;
  }

  KeyboardScheme buildKeyboard() {
    final keyboard = <List<LetterStateWithKey>>[];

    for (final row in keyboardScheme) {
      final keyboardRow = <LetterStateWithKey>[];

      for (final key in row) {
        final value = LetterStateWithKey.fromLetterKey(key);
        keyboardRow.add(value);
      }

      keyboard.add(keyboardRow);
    }

    return keyboard;
  }

  KeyboardScheme updateKeyboard({
    required KeyboardScheme oldKeyboard,
    required String guessedWord,
    required List<LetterPositionState> result,
  }) {
    assert(
      guessedWord.length == result.length,
      'Guessed word length must be equal to result length',
    );

    final newKeyboard = <List<LetterStateWithKey>>[];

    for (var rowIndex = 0; rowIndex < oldKeyboard.length; rowIndex += 1) {
      final row = oldKeyboard[rowIndex];

      for (var columnIndex = 0; columnIndex < row.length; columnIndex += 1) {
        final key = row[columnIndex];

        if (key.key is KeyboardKeyTypeLetter) {
          final letter = key.key as KeyboardKeyTypeLetter;

          final letterIndex = guessedWord.indexOf(letter.letter);

          if (letterIndex != -1) {
            row[columnIndex] = LetterStateWithKey(
              state: result[letterIndex],
              key: key.key,
            );
          }
        }
      }

      newKeyboard.add(row);
    }

    return newKeyboard;
  }

  /// Determines if on the [board] at [boardIndex] all letters are\
  /// [LetterPositionState.correct].
  bool isGameWon({
    required BoardScheme board,
    required int boardIndex,
  }) {
    assert(
      boardIndex >= 0 && boardIndex < board.length,
      'Board index must be in range of board length',
    );

    final row = board[boardIndex];

    return row.every(
      (element) => element.state == LetterPositionState.correct,
    );
  }

  /// Game is over when [isGameWon] or when [boardIndex] is equal to the last
  /// index of [board].
  bool isGameOver({
    required BoardScheme board,
    required int boardIndex,
  }) {
    assert(
      boardIndex >= 0 && boardIndex < board.length,
      'Board index must be in range of board length',
    );

    return isGameWon(
          board: board,
          boardIndex: boardIndex,
        ) ||
        boardIndex == board.length - 1;
  }
}
