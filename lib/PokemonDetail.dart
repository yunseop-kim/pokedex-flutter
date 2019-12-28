import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './models/Pokehub.dart';

// 데이터 변동이 없으므로 stateless widget으로 한다.
class PokemonDetail extends StatefulWidget {
  final String name;

  PokemonDetail(this.name);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  Pokemon pokemon;

  Widget bodyWidget() => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    pokemon.name,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "Height: ${pokemon.height.minimum} ~ ${pokemon.height.maximum}"),
                  Text(
                      "Weight: ${pokemon.weight.minimum} ~ ${pokemon.weight.maximum}"),
                  Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.types
                        .map((t) => FilterChip(
                            backgroundColor: Colors.amber,
                            label: Text(t),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  Text(
                    "Weakness",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.weaknesses
                          .map((t) => Container(
                                margin: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: FilterChip(
                                    backgroundColor: Colors.red,
                                    label: Text(
                                      t,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onSelected: (b) {}),
                              ))
                          .toList(),
                    ),
                  ),
                  Text(
                    "Next Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.evolutions.length > 0
                        ? pokemon.evolutions
                            .map((t) => FilterChip(
                                backgroundColor: Colors.green,
                                label: Text(
                                  t.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onSelected: (b) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PokemonDetail(
                                                t.name,
                                              )));
                                }))
                            .toList()
                        : [Text("This is the final stage of evolution.")],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(pokemon.image))),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    final String doc = '''
    {
      pokemon(name: "${widget.name}") {
        id
        number
        name
        weight {
          minimum
          maximum
        }
        height {
          minimum
          maximum
        }
        classification
        types
        resistant
        attacks{
          fast {
            name
            type
            damage
          }
          special {
            name
            type
            damage
          }
        }
        weaknesses
        fleeRate
        maxCP
        evolutions {
          name
        }
        evolutionRequirements {
          amount
          name
        }
        maxHP
        image
      }
    }
    ''';
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Query(
        options: QueryOptions(documentNode: gql(doc)),
        builder: (QueryResult result, {Refetch refetch, FetchMore fetchMore}) {
          if (result.data != null) {
            pokemon = Pokemon.fromJson(result.data['pokemon']);
            return bodyWidget();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
