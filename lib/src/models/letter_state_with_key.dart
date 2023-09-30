import 'package:equatable/equatable.dart';
import 'package:wordle_api/wordle_api.dart';

class LetterStateWithKey with EquatableMixin {
  const LetterStateWithKey({
    required this.state,
    required this.key,
  });

  factory LetterStateWithKey.fromLetterKey(
    KeyboardKeyType key,
  ) {
    return LetterStateWithKey(
      key: key,
      state: key is KeyboardKeyTypeLetter
          ? LetterPositionState.empty
          : LetterPositionState.none,
    );
  }

  const LetterStateWithKey.empty()
      : this(
          state: LetterPositionState.empty,
          key: const KeyboardKeyTypeLetter(''),
        );

  final LetterPositionState state;
  final KeyboardKeyType key;

  @override
  List<Object?> get props => [state, key];

  @override
  bool? get stringify => true;
}
