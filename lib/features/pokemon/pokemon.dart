import 'package:flutter/material.dart';

@immutable
class Pokemon {
  final int id;
  final String name;
  final Sprites sprites;
  final List<Move> moves;

  const Pokemon(
      {required this.id,
      required this.name,
      required this.sprites,
      required this.moves});

  const Pokemon.initial()
      : id = 0,
        name = '',
        sprites = const Sprites(back_default: '', front_default: ''),
        moves = const [Move(move: Species(name: '', url: ''))];

  @override
  String toString() =>
      'Pokemon(id: $id), name: $name, sprites$sprites, moves:$moves)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pokemon &&
        other.id == id &&
        other.name == name &&
        other.sprites == sprites &&
        other.moves == moves;
  }

  @override
  int get hashCode =>
      name.hashCode ^ id.hashCode ^ sprites.hashCode ^ moves.hashCode;
}

@immutable
class Sprites {
  final String back_default;
  final String front_default;

  const Sprites({
    required this.back_default,
    required this.front_default,
  });

  @override
  String toString() =>
      'Sprites(backDefault: $back_default, frontDefault: $front_default)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sprites &&
        other.front_default == front_default &&
        other.back_default == back_default;
  }

  @override
  int get hashCode => back_default.hashCode ^ front_default.hashCode;
}

@immutable
class Species {
  final String name;
  final String url;

  const Species({
    required this.name,
    required this.url,
  });
}

@immutable
class Move {
  final Species move;

  const Move({
    required this.move,
  });
}
