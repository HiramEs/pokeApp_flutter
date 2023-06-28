import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex_service.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex_state.dart';
import 'package:poke_app_flutter/features/pokemon/pokemon.dart';

final pokedexControllerProvider =
    StateNotifierProvider.autoDispose<PokedexController, PokedexState>((ref) {
  return PokedexController(
      const PokedexState(
        pokedex: AsyncValue.data([]),
        pokemon: AsyncValue.data(Pokemon.initial()),
      ),
      ref.watch(pokedexServiceProvider));
});

class PokedexController extends StateNotifier<PokedexState> {
  PokedexController(PokedexState state, this._pokedexService) : super(state) {
    loadPokedex();
  }

  final PokedexService _pokedexService;

  Future<void> loadPokedex() async {
    state = state.copyWith(pokedex: const AsyncValue.loading());
    final result = await _pokedexService.getPokedexEntries();

    state = state.copyWith(pokedex: AsyncValue.data(result));
  }

  Future<void> getPokemon(String name) async {
    state = state.copyWith(pokemon: const AsyncValue.loading());
    final result = await _pokedexService.getPokemon(name);

    state = state.copyWith(pokemon: AsyncValue.data(result));
  }
}
