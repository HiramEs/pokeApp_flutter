import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex.dart';
import 'package:poke_app_flutter/features/pokemon/pokemon.dart';

@immutable
class PokedexState {
  final AsyncValue<List<PokedexEntry>> pokedex;
  final AsyncValue<Pokemon> pokemon;

  const PokedexState({required this.pokedex, required this.pokemon});

  PokedexState copyWith({
    AsyncValue<List<PokedexEntry>>? pokedex,
    AsyncValue<Pokemon>? pokemon,
  }) {
    return PokedexState(
        pokedex: pokedex ?? this.pokedex, pokemon: pokemon ?? this.pokemon);
  }

  @override
  String toString() => 'PokedexState(pokedex: $pokedex, pokemon: $pokemon)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokedexState &&
        other.pokedex == pokedex &&
        other.pokemon == pokemon;
  }

  @override
  int get hashCode => pokedex.hashCode ^ pokemon.hashCode;
}
