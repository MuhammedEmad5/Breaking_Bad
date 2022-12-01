import 'package:breaking_bad/data/api_server/characters_dio.dart';
import 'package:breaking_bad/data/model/quote.dart';

import '../model/characters_model.dart';

class CharactersRepository {
  final CharactersDio charactersDio;

  CharactersRepository(this.charactersDio);

  Future<List<CharactersModel>> getAllCharacters() async {
    final characters = await charactersDio.getAllCharacters();
    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }

  Future<List<Quotes>> getCharacterQuote(String characterName) async {
    final quotes = await charactersDio.getCharacterQuote(characterName);
    return quotes.map((quote) => Quotes.fromJson(quote)).toList();
  }
}
