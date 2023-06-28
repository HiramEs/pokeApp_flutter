import 'package:flutter/material.dart';
import 'package:poke_app_flutter/features/pokemon/pokemon_entity.dart';

@immutable
class Pokemon {
  final int id;
  final String name;
  final Sprites sprites;

  const Pokemon({required this.id, required this.name, required this.sprites});

  const Pokemon.initial()
      : id = 0,
        name = '',
        sprites = const Sprites(backDefault: '', frontDefault: '');

  factory Pokemon.fromEntity(PokemonEntity entity) {
    return Pokemon(id: entity.id, name: entity.name, sprites: entity.sprites);
  }

  @override
  String toString() => 'Pokemon(id: $id), name: $name, sprites$sprites)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pokemon &&
        other.id == id &&
        other.name == name &&
        other.sprites == sprites;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ sprites.hashCode;
}

@immutable
class Sprites {
  final String backDefault;
  final String frontDefault;

  const Sprites({
    required this.backDefault,
    required this.frontDefault,
  });

  @override
  String toString() =>
      'Sprites(backDefault: $backDefault, frontDefault: $frontDefault)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sprites &&
        other.frontDefault == frontDefault &&
        other.backDefault == backDefault;
  }

  @override
  int get hashCode => backDefault.hashCode ^ frontDefault.hashCode;
}
