import 'package:flutter/foundation.dart';
import 'package:poke_app_flutter/features/pokemon/pokemon.dart';

@immutable
class PokemonEntity {
  final String name;
  final int id;
  final Sprites sprites;

  const PokemonEntity(
      {required this.name, required this.id, required this.sprites});

  factory PokemonEntity.fromMap(Map<String, dynamic> map) {
    return PokemonEntity(
        name: map['name'], id: map['id'], sprites: map['sprites']);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonEntity &&
        other.id == id &&
        other.name == name &&
        other.sprites == sprites;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ sprites.hashCode;
  }

  @override
  String toString() {
    return 'PokemonEntity(id: $id, name: $name, sprites $sprites)';
  }
}
