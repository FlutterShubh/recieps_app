class Ingredient {
  int? id;
  String? aisle;
  bool isFav;
  String? image;
  String? consistency;
  String? name;
  String? nameClean;
  String? original;
  String? originalName;
  double? amount;
  String? unit;
  List<String>? meta;
  Measures? measures;

  Ingredient({
    this.id,
    this.aisle,
    this.isFav = false,
    this.image,
    this.consistency,
    this.name,
    this.nameClean,
    this.original,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.measures,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      aisle: json['aisle'],
      image: json['image'],
      isFav:json['isFav'] ?? false,
      consistency: json['consistency'],
      name: json['name'],
      nameClean: json['nameClean'],
      original: json['original'],
      originalName: json['originalName'],
      amount: json['amount'],
      unit: json['unit'],
      meta: List<String>.from(json['meta'] ?? []),
      measures: json['measures'] != null ? Measures.fromJson(json['measures']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aisle': aisle,
      'image': image,
      'isFav':isFav,
      'consistency': consistency,
      'name': name,
      'nameClean': nameClean,
      'original': original,
      'originalName': originalName,
      'amount': amount,
      'unit': unit,
      'meta': meta,
      'measures': measures?.toJson(),
    };
  }
}

class Measures {
  MeasureUnit? us;
  MeasureUnit? metric;

  Measures({
    this.us,
    this.metric,
  });

  factory Measures.fromJson(Map<String, dynamic> json) {
    return Measures(
      us: json['us'] != null ? MeasureUnit.fromJson(json['us']) : null,
      metric: json['metric'] != null ? MeasureUnit.fromJson(json['metric']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'us': us?.toJson(),
      'metric': metric?.toJson(),
    };
  }
}

class MeasureUnit {
  double? amount;
  String? unitShort;
  String? unitLong;

  MeasureUnit({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  factory MeasureUnit.fromJson(Map<String, dynamic> json) {
    return MeasureUnit(
      amount: json['amount'],
      unitShort: json['unitShort'],
      unitLong: json['unitLong'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'unitShort': unitShort,
      'unitLong': unitLong,
    };
  }
}

