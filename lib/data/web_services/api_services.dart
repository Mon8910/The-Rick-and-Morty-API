
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import '../../constances.dart';
import '../model/character_model.dart';

class CharactersWebServices {
  Future<http.Response> fetchData()async{
    final response=await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    return response;

  }
}
