import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'busniess_logic/cubit/charcters_cubit.dart';
import 'data/model/character_model.dart';
import 'data/repository/charaacter_repo.dart';
import 'data/web_services/api_services.dart';
import 'presentation/screens/character.dart';
import 'presentation/screens/characters_details_screen.dart';

class AppRouter {
  late CharacterRepo characterRepo;
  late CharctersCubit charctersCubit;

  AppRouter() {
    characterRepo = CharacterRepo(CharactersWebServices());
    charctersCubit = CharctersCubit(characterRepo);
  }

  // ignore: body_might_complete_normally_nullable
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charctersCubit,
            child: const CharacterScreen(),
          ),
        );
      case './characterDetailsScreen' :
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) => CharactersDetailsScreen(
                  character: character,
                ));
    }
  }
}
