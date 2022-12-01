import 'package:breaking_bad/business_logic/characters_cubit/cubit.dart';
import 'package:breaking_bad/data/model/characters_model.dart';
import 'package:breaking_bad/presentation/screens/characters_details_screen.dart';
import 'package:breaking_bad/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String charactersScreen = '/';
  static const String charactersDetailsScreen = '/CharactersDetailsScreen';
}

class RouteGenerate {
  // static late CharactersRepository charactersRepository;
  // static late CharactersCubit charactersCubit;
  //
  // RouteGenerate() {
  //   charactersRepository = CharactersRepository(CharactersDio());
  //   charactersCubit = CharactersCubit(charactersRepository);
  // }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    CharactersCubit(),
                child: CharactersScreen()));

      case AppRoutes.charactersDetailsScreen:
        final character = settings.arguments as CharactersModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    CharactersCubit()..getCharactersQuotes(character.name!),
                child: CharactersDetailsScreen(
                  character: character,
                )));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Not Found'),
              ),
            ));
  }
}
