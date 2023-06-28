import 'package:dio/dio.dart';
import 'package:poke_app_flutter/features/pokemon/pokemon.dart';

class PokemonService {
  Future<Pokemon> getPokemon(String url) async {
    final dio = Dio();

    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final result = response.data;
      print(result['moves']);
      return Pokemon(
        id: result['id'],
        name: result['name'],
        sprites: Sprites(
            back_default: result['sprites']['back_default'],
            front_default: result['sprites']['front_default']),
        moves: List<Move>.from(result['moves'].map((x) => Move(
            move: Species(name: x['move']['name'], url: x['move']['url'])))),
      );
    }

    return const Pokemon.initial();
  }
}
