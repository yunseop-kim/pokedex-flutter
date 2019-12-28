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

class Pokemon {
  String id;
  String number;
  String name;
  Weight weight;
  Weight height;
  String classification;
  List<String> types;
  List<String> resistant;
  Attacks attacks;
  List<String> weaknesses;
  double fleeRate;
  int maxCP;
  List<Evolutions> evolutions;
  EvolutionRequirements evolutionRequirements;
  int maxHP;
  String image;

  Pokemon(
      {this.id,
      this.number,
      this.name,
      this.weight,
      this.height,
      this.classification,
      this.types,
      this.resistant,
      this.attacks,
      this.weaknesses,
      this.fleeRate,
      this.maxCP,
      this.evolutions,
      this.evolutionRequirements,
      this.maxHP,
      this.image});

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    name = json['name'];
    weight =
        json['weight'] != null ? new Weight.fromJson(json['weight']) : null;
    height =
        json['height'] != null ? new Weight.fromJson(json['height']) : null;
    classification = json['classification'];
    types = json['types'].cast<String>();
    resistant = json['resistant'].cast<String>();
    attacks =
        json['attacks'] != null ? new Attacks.fromJson(json['attacks']) : null;
    weaknesses = json['weaknesses'].cast<String>();
    fleeRate = json['fleeRate'];
    maxCP = json['maxCP'];
    if (json['evolutions'] != null) {
      evolutions = new List<Evolutions>();
      json['evolutions'].forEach((v) {
        evolutions.add(new Evolutions.fromJson(v));
      });
    } else {
      evolutions = new List<Evolutions>();
    }
    evolutionRequirements = json['evolutionRequirements'] != null
        ? new EvolutionRequirements.fromJson(json['evolutionRequirements'])
        : null;
    maxHP = json['maxHP'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['name'] = this.name;
    if (this.weight != null) {
      data['weight'] = this.weight.toJson();
    }
    if (this.height != null) {
      data['height'] = this.height.toJson();
    }
    data['classification'] = this.classification;
    data['types'] = this.types;
    data['resistant'] = this.resistant;
    if (this.attacks != null) {
      data['attacks'] = this.attacks.toJson();
    }
    data['weaknesses'] = this.weaknesses;
    data['fleeRate'] = this.fleeRate;
    data['maxCP'] = this.maxCP;
    if (this.evolutions != null) {
      data['evolutions'] = this.evolutions.map((v) => v.toJson()).toList();
    }
    if (this.evolutionRequirements != null) {
      data['evolutionRequirements'] = this.evolutionRequirements.toJson();
    }
    data['maxHP'] = this.maxHP;
    data['image'] = this.image;
    return data;
  }
}

class Weight {
  String minimum;
  String maximum;

  Weight({this.minimum, this.maximum});

  Weight.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    return data;
  }
}

class Attacks {
  List<Attack> fast;
  List<Attack> special;

  Attacks({this.fast, this.special});

  Attacks.fromJson(Map<String, dynamic> json) {
    if (json['fast'] != null) {
      fast = new List<Attack>();
      json['fast'].forEach((v) {
        fast.add(new Attack.fromJson(v));
      });
    }
    if (json['special'] != null) {
      special = new List<Attack>();
      json['special'].forEach((v) {
        special.add(new Attack.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fast != null) {
      data['fast'] = this.fast.map((v) => v.toJson()).toList();
    }
    if (this.special != null) {
      data['special'] = this.special.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attack {
  String name;
  String type;
  int damage;

  Attack({this.name, this.type, this.damage});

  Attack.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    damage = json['damage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['damage'] = this.damage;
    return data;
  }
}

class Evolutions {
  String name;

  Evolutions({this.name});

  Evolutions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class EvolutionRequirements {
  int amount;
  String name;

  EvolutionRequirements({this.amount, this.name});

  EvolutionRequirements.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['name'] = this.name;
    return data;
  }
}