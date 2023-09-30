import 'package:equatable/equatable.dart';

sealed class KeyboardKeyType with EquatableMixin {
  const KeyboardKeyType();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

final class KeyboardKeyTypeLetter extends KeyboardKeyType {
  const KeyboardKeyTypeLetter(this.letter);
  final String letter;

  @override
  List<Object?> get props => [letter];
}

final class KeyboardKeyTypeDelete extends KeyboardKeyType {
  const KeyboardKeyTypeDelete();
}

final class KeyboardKeyTypeEnter extends KeyboardKeyType {
  const KeyboardKeyTypeEnter();
}
