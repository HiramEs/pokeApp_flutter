import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex_controller.dart';
import 'package:poke_app_flutter/theme/palette.dart';

class PokemonDetails extends ConsumerWidget {
  const PokemonDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(pokedexControllerProvider).pokemon.when(
          data: (pokemon) {
            return Scaffold(
              appBar: AppBar(
                title: Text(pokemon.name),
              ),
            );
          },
          error: (e, s) {
            return Text('Fail');
          },
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
  }
}
