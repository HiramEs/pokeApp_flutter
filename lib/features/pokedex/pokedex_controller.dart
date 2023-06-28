import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex_service.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex_state.dart';

final pokedexControllerProvider =
    StateNotifierProvider.autoDispose<PokedexController, PokedexState>((ref) {
  return PokedexController(
      const PokedexState(
        pokedex: AsyncValue.data([]),
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

  void searchPokemon(String name) {
    final results = state.pokedex.asData?.value.where((poke) {
      final pokeName = poke.name.toLowerCase();
      final query = name.toLowerCase();

      return pokeName.contains(query);
    }).toList();

    if (results != null) {
      state = state.copyWith(pokedex: AsyncValue.data(results));
    }
  }
}
