class Pokehub {
  List<Pokemons> pokemons;

  Pokehub({this.pokemons});

  Pokehub.fromJson(Map<String, dynamic> json) {
    if (json['pokemons'] != null) {
      pokemons = new List<Pokemons>();
      json['pokemons'].forEach((v) {
        pokemons.add(new Pokemons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pokemons != null) {
      data['pokemons'] = this.pokemons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pokemons {
  String name;
  String image;

  Pokemons({this.name, this.image});

  Pokemons.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
