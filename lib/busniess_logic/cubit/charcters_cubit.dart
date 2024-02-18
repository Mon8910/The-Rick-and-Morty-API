import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/character_model.dart';
import '../../data/repository/charaacter_repo.dart';

part 'charcters_state.dart';

class CharctersCubit extends Cubit<CharctersState> {
  final CharacterRepo characterRepo;
   List<CharacterModel> character=[];
  CharctersCubit(this.characterRepo) : super(CharctersInitial());


  List<CharacterModel> fetchChatracter(){
    characterRepo.fetchChatracter().then((character) {
      emit(Characterloaded(character));
      this.character=character;
    });
    return character;
  }
}
