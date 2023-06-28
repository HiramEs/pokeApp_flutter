import 'package:flutter/foundation.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex_entity.dart';

@immutable
class PokedexEntry {
  final String name;
  final String url;

  const PokedexEntry({
    required this.name,
    required this.url,
  });

  factory PokedexEntry.fromEntity(PokedexEntryEntity entity) {
    return PokedexEntry(name: entity.name, url: entity.url);
  }

  @override
  String toString() => 'PokedexEntry(name: $name, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokedexEntry && other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
