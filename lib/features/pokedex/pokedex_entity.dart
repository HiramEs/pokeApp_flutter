import 'package:flutter/foundation.dart';

@immutable
class PokedexEntryEntity {
  final String name;
  final String url;

  const PokedexEntryEntity({
    required this.name,
    required this.url,
  });

  factory PokedexEntryEntity.fromMap(Map<String, dynamic> map) {
    return PokedexEntryEntity(name: map['name'], url: map['url']);
  }

  @override
  String toString() => 'PokedexEntryEntity(name: $name, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokedexEntryEntity &&
        other.name == name &&
        other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
