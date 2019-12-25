import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './models/Pokehub.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(uri: "https://graphql-pokemon.now.sh/");
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(
            link: httpLink,
            cache:
                OptimisticCache(dataIdFromObject: typenameDataIdFromObject)));
    return GraphQLProvider(
        child: MaterialApp(
          title: 'Pokedex',
          home: HomePage(title: 'Pokedex Home Page'),
          debugShowCheckedModeBanner: false,
        ),
        client: client);
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pokehub pokehub;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String doc = '''
    {
      pokemons(first: 151) {
        name
        image
      }
    }
    ''';
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex App"),
        backgroundColor: Colors.cyan,
      ),
      body: Query(
          options: QueryOptions(documentNode: gql(doc)),
          builder: (
            QueryResult result, {
            Refetch refetch,
            FetchMore fetchMore,
          }) {
            pokehub = Pokehub.fromJson(result.data);
            return GridView.count(
                crossAxisCount: 2,
                children: pokehub.pokemons
                    .map((poke) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                              elevation: 3.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(poke.image))),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ))
                    .toList());
          }),
    );
  }
}
