import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_app_flutter/features/pokedex/pokedex_controller.dart';
import 'package:poke_app_flutter/features/pokemon/pokemon_details.dart';
import 'package:poke_app_flutter/theme/palette.dart';

class Pokedex extends ConsumerWidget {
  const Pokedex({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Pokedex'),
          backgroundColor: Palette.pokeRed,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.0),
            ),
          ),
        ),
        body: ref.watch(pokedexControllerProvider).pokedex.when(
              data: (pokedex) {
                if (pokedex.isEmpty) {
                  return const Text('Fail');
                }

                return ListView.builder(
                  itemCount: pokedex.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(pokedex[index].name),
                      leading: Text((index + 1).toString()),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () async {
                        await ref
                            .watch(pokedexControllerProvider.notifier)
                            .getPokemon(pokedex[index].name);
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PokemonDetails()));
                      },
                    );
                  },
                );
              },
              error: (e, s) {
                return const Text('Fail');
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}
