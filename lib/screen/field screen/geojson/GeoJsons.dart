class FeatureCollection {
  final String type;
  final List<Feature> features;

  FeatureCollection({required this.type, required this.features});

  factory FeatureCollection.fromJson(Map<String, dynamic> json) {
    var list = json['features'] as List;
    List<Feature> featuresList = list.map((i) => Feature.fromJson(i)).toList();

    return FeatureCollection(
      type: json['type'],
      features: featuresList,
    );
  }
}

class Feature {
  final String type;
  final String id;
  final Properties properties;
  final Geometry geometry;

  Feature(
      {required this.type,
      required this.id,
      required this.properties,
      required this.geometry});

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      type: json['type'],
      id: json['id'],
      properties: Properties.fromJson(json['properties']),
      geometry: Geometry.fromJson(json['geometry']),
    );
  }
}

class Properties {
  final String id;
  final String name;

  Properties({required this.id, required this.name});

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Geometry {
  final String type;
  final List<List<List<List<double>>>> coordinates;

  Geometry({required this.type, required this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    var list = json['coordinates'] as List;
    List<List<List<List<double>>>> coordinatesList =
        list.map((i) => i as List<List<List<double>>>).toList();

    return Geometry(
      type: json['type'],
      coordinates: coordinatesList,
    );
  }
}
