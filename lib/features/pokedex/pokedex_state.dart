import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex.dart';

@immutable
class PokedexState {
  final AsyncValue<List<PokedexEntry>> pokedex;

  const PokedexState({required this.pokedex});

  PokedexState copyWith({
    AsyncValue<List<PokedexEntry>>? pokedex,
  }) {
    return PokedexState(pokedex: pokedex ?? this.pokedex);
  }

  @override
  String toString() => 'PokedexState(pokedex: $pokedex)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokedexState && other.pokedex == pokedex;
  }

  @override
  int get hashCode => pokedex.hashCode;
}
