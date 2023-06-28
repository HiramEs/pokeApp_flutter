import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex_repository.dart';

final pokedexServiceProvider = Provider<PokedexService>((ref) {
  final pokedexRepository = ref.watch(pokedexRepositoryProvider);
  return SetPokedexService(pokedexRepository);
});

abstract class PokedexService {
  Future<List<PokedexEntry>> getPokedexEntries();
}

class SetPokedexService implements PokedexService {
  SetPokedexService(this._pokedexRepository);
  final PokedexRepository _pokedexRepository;

  @override
  Future<List<PokedexEntry>> getPokedexEntries() async {
    final pokedexEntryEntities = await _pokedexRepository.getPokedexEntries();
    final pokedexEntries =
        pokedexEntryEntities.map((e) => PokedexEntry.fromEntity(e)).toList();
    return pokedexEntries;
  }
}
