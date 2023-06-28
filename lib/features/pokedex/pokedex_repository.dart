import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex_entity.dart';
import 'package:poke_app_flutter/features/pokemon/pokemon_entity.dart';
import 'package:poke_app_flutter/main.dart';

final pokedexRepositoryProvider = Provider<PokedexRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return NewPokedexRepository(dio: dio);
});

abstract class PokedexRepository {
  Future<List<PokedexEntryEntity>> getPokedexEntries();
  Future<PokemonEntity> getPokemon(String name);
}

class NewPokedexRepository implements PokedexRepository {
  NewPokedexRepository({required this.dio});
  final Dio dio;

  @override
  Future<List<PokedexEntryEntity>> getPokedexEntries() async {
    final response = await dio.get('pokemon/?offset=0&limit=30"');
    final results = List<Map<String, dynamic>>.from(response.data['results']);

    final pokedexEntries =
        results.map((e) => PokedexEntryEntity.fromMap(e)).toList();

    return pokedexEntries;
  }

  @override
  Future<PokemonEntity> getPokemon(String name) async {
    final response = await dio.get('pokemon/$name');
    final results = response.data;

    final pokemon = results.map((e) => PokemonEntity.fromMap(e));

    return pokemon;
  }
}
