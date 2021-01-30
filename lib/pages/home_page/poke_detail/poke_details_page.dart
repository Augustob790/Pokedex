import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailsPage extends StatelessWidget {
  final int index;

  Color _corPokemon;

  PokeDetailsPage({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    Pokemon _pokemon = _pokemonStore.getPokemon(index: this.index);
    _corPokemon = ConstsAPI.getColorType(type: _pokemon.type[0]);
    return Scaffold(
      appBar: AppBar(
        title: Opacity(
          opacity: 0.0,
          child: Text(
            _pokemon.name,
            style: TextStyle(
                fontFamily: 'Google',
                fontWeight: FontWeight.bold,
                fontSize: 21),
          ),
        ),
        elevation: 0,
        backgroundColor: _corPokemon,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: _corPokemon,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
          ),
          SlidingSheet(
            elevation: 0,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 60),
            child: SizedBox(
              height: 150,
              child: PageView.builder(
                itemCount: _pokemonStore.pokeAPI.pokemon.length,
                itemBuilder: (BuildContext context, int count) {
                  Pokemon _pokeitem = _pokemonStore.getPokemon(index: count);
                  return CachedNetworkImage(
                    height: 60,
                    width: 60,
                    placeholder: (context, url) => Container(
                      color: Colors.transparent,
                    ),
                    imageUrl:
                        'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeitem.num}.png',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
