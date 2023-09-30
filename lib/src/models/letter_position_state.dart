/// Defines the state of a letter in a word. A letter can be correct, present,
/// or absent.
/// - Empty: the letter has not been guessed yet.
/// - Correct: the letter is in the correct position.
/// - Present: the letter is in the word, but not in the correct position.
/// - Absent: the letter is not in the word.
/// - None: the letter has no state. Its enter and back buttons.
enum LetterPositionState {
  empty,
  correct,
  present,
  absent,
  none,
}
