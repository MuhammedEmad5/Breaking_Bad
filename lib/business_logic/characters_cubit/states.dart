
import 'package:breaking_bad/data/model/quote.dart';

import '../../data/model/characters_model.dart';

abstract class CharactersStates{}

class InitialCharactersState extends CharactersStates {}

class CharactersSuccessState extends CharactersStates {
  final List<CharactersModel>characters;
  CharactersSuccessState(this.characters);
}
class CharactersErrorState extends CharactersStates {}

class SendSearchWordState extends CharactersStates{}

class StartSearchState extends CharactersStates{}
class CloseSearchState extends CharactersStates{}

class GetCharacterQuotesState extends CharactersStates{
  final List<Quotes>quotes;

  GetCharacterQuotesState(this.quotes);
}