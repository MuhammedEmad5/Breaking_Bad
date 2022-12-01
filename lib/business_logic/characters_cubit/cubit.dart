import 'package:breaking_bad/business_logic/characters_cubit/states.dart';
import 'package:breaking_bad/data/api_server/characters_dio.dart';
import 'package:breaking_bad/data/model/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/characters_model.dart';
import '../../data/repository/characters_repository.dart';


class CharactersCubit extends Cubit<CharactersStates>{

  final CharactersRepository charactersRepository=CharactersRepository(CharactersDio());
  CharactersCubit():super(InitialCharactersState());

 static CharactersCubit get(context)=>BlocProvider.of(context);


  List<CharactersModel>allCharacters=[];
  List<CharactersModel> getAllCharacters(){
    charactersRepository.getAllCharacters().then((characters) {
      allCharacters=characters;
      emit(CharactersSuccessState(characters));
    });
    return allCharacters;
  }


  late List<CharactersModel> searchedCharactersResult;
  void searchCharacterByWord(searchedWord,context) {
    searchedCharactersResult =allCharacters
        .where(
            (element) => element.name!.toLowerCase().startsWith(searchedWord))
        .toList();
    emit(SendSearchWordState());
  }


  bool isSearchingNow = false;
  var searchCharacterController = TextEditingController();
  void startSearch(){
    isSearchingNow = true;
    emit(StartSearchState());
  }
  void closeSearch(){
    searchCharacterController.clear();
    isSearchingNow = false;
    emit(CloseSearchState());
  }


  List<Quotes>quotes=[];
  List<Quotes> getCharactersQuotes(String characterName){
    charactersRepository.getCharacterQuote(characterName).then((quotes) {
      this.quotes=quotes;
      emit(GetCharacterQuotesState(quotes));
    });
    return quotes;
  }

}
