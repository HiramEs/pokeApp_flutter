import 'package:flutter/material.dart';
import 'package:poke_app_flutter/features/pokemon/pokemon.dart';
import 'package:poke_app_flutter/features/pokemon/pokemon_service.dart';
import 'package:poke_app_flutter/theme/palette.dart';

class PokemonDetails extends StatefulWidget {
  const PokemonDetails({super.key, this.pokemonName = '', this.url = ''});

  final String pokemonName;
  final String url;

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  Pokemon? pokemon;
  var isLoaded = false;
  var front = true;

  @override
  void initState() {
    super.initState();
    getPokemonDetails();
  }

  getPokemonDetails() async {
    pokemon = await PokemonService().getPokemon(widget.url);
    if (pokemon != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemonName),
        backgroundColor: Palette.pokeRed,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: pokemon?.name != null
            ? Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    pokemon!.name.toUpperCase(),
                    style: const TextStyle(color: Colors.black, fontSize: 30.0),
                  ),
                  Center(
                      child: front
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  front = !front;
                                });
                              },
                              child: SizedBox(
                                width: 300.0,
                                height: 300.0,
                                child: Image.network(
                                  pokemon!.sprites.front_default,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  front = !front;
                                });
                              },
                              child: SizedBox(
                                width: 300.0,
                                height: 300.0,
                                child: Image.network(
                                  pokemon!.sprites.back_default,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )),
                  const Text('Moves', style: TextStyle(fontSize: 20)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: pokemon!.moves.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(pokemon!.moves[index].move.name),
                          leading: const Icon(Icons.alternate_email_sharp),
                        );
                      },
                    ),
                  )
                ],
              )
            : const Text("Loading ..."),
      ),
    );
  }
}
