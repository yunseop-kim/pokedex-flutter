import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import "package:gql/language.dart" as lang;
import "package:gql/ast.dart" as ast;

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ast.DocumentNode doc = lang.parseString(
      """
    {
      pokemons(first: 151) {
        name
      }
    }
    """,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex App"),
        backgroundColor: Colors.cyan,
      ),
      body: Query(
          options: QueryOptions(documentNode: doc),
          builder: (
            QueryResult result, {
            Refetch refetch,
            FetchMore fetchMore,
          }) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text(result.data["pokemons"][index]["name"]);
              },
              itemCount: result.data["pokemons"].length,
            );
          }),
    );
  }
}
