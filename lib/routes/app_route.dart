import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/cubit/characters_cubit.dart';
import '../data/models/character.dart';
import '../data/repository/character_repository.dart';
import '../data/web_services/character_web_services.dart';
import '../presentation/screens/character_details_screen.dart';
import '../presentation/screens/characters_screen.dart';
import 'app_pages.dart';

class AppRoutes {
  late CharactersCubit charactersCubit;
  late CharacterRepository characterRepository;

  AppRoutes() {
    characterRepository = CharacterRepository(CharacterWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppPages.charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case AppPages.characterDetailsScreen:
        final Character character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(character: character),
        );
    }

    return null;
  }
}
