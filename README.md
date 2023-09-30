<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Wordle dart client library. Provides a virtual wordle board and keyboard to play the game.
You can set custom word length and number of guesses.

## Features

Create wordle games and get the results.

## Usage

See the [example](example/wordle_api_example.dart) for a complete example.

```dart
const gameService = WordleGameFactory();

final guessedWord = 'hello';
final targetWord = 'dream';

final comparison = compareWords(guessedWord, targetWord);
```

Pay special attention to [LetterPositionState](lib/src/models/letter_position_state.dart).

## Additional information

Any contributions are welcome. Please open an issue or a pull request.
