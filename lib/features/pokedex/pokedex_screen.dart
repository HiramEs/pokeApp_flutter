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
          backgroundColor: Palette.pokeRed,
          title: Container(
            width: double.infinity,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: TextField(
                onChanged: (value) {
                  if (value != '') {
                    ref
                        .watch(pokedexControllerProvider.notifier)
                        .searchPokemon(value);
                  } else {
                    ref.watch(pokedexControllerProvider.notifier).loadPokedex();
                  }
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search ...",
                    prefixIconColor: Palette.pokeRed,
                    suffixIconColor: Palette.pokeRed,
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
        body: ref.watch(pokedexControllerProvider).pokedex.when(
              data: (pokedex) {
                if (pokedex.isEmpty) {
                  return const Center(
                      child: Text(
                    'No Pokemon',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ));
                }

                return ListView.builder(
                  itemCount: pokedex.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(pokedex[index].name),
                        leading: Text((index + 1).toString()),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PokemonDetails(
                                  pokemonName:
                                      pokedex[index].name.toUpperCase(),
                                  url: pokedex[index].url,
                                ),
                              ));
                        });
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
