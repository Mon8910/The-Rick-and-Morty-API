import 'dart:convert';
import 'dart:developer';

import '../model/character_model.dart';
import '../web_services/api_services.dart';

class CharacterRepo {
  final CharactersWebServices charactersWebServices;

  CharacterRepo(this.charactersWebServices);
  Future<List<CharacterModel>> fetchChatracter() async {
    final  response = await charactersWebServices.fetchData();
    if (response.statusCode == 200) {
      final Map<String,dynamic> data = json.decode(response.body);
      log('----------------${data['results']}');
      final occaionsData = data['results'];
      final List<CharacterModel> occasionList =
          CharacterModel.occasionTypelist(occaionsData);
          print(occasionList);
         
          return occasionList;

      
       
       
    }
    else{
      return [];
    }
  }
  List<CharacterModel> getBooksList(Map<String, dynamic> data) {
    List<CharacterModel> books = [];
    for (var bookMap in data['results'] ) {
      books.add(CharacterModel.fromJson(bookMap ));
    }
    return books;
  }
}
