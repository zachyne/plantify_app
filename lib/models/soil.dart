export 'soil.dart';

class Soil {
  final String id;
  final String name;
  final String imagePath;
  final String description;
  final String amendments;

  Soil({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.amendments,
  });

  // Convert a Soil instance into a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'description': description,
      'amendments': amendments,
    };
  }

  factory Soil.fromCSV(List<dynamic> row) {
  return Soil(
    id: row[0]?.toString() ?? '',
    name: row[1]?.toString() ?? '',
    imagePath: 'assets/images/soil/${row[2]?.toString() ?? ''}',
    description: row[3]?.toString() ?? '',
    amendments: row[4]?.toString() ?? '',
  );
}

  // Create a Soil instance from a Map (JSON)
  factory Soil.fromJson(Map<String, dynamic> json) {
    return Soil(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
      description: json['description'],
      amendments: json['amendments'],
    );
  }
}

// Function to recreate Soil instances from JSON
List<Soil> soilsFromJson(List<Map<String, dynamic>> jsonList) {
  return jsonList.map((json) => Soil.fromJson(json)).toList();
}


