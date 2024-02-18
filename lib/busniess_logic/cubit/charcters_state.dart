part of 'charcters_cubit.dart';

@immutable
sealed class CharctersState {}

class CharctersInitial extends CharctersState {}

class Characterloaded extends CharctersState {
  final List<CharacterModel> characters;

  Characterloaded(this.characters);
}
