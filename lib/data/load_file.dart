// import 'package:csv/csv.dart';
// import 'package:flutter/services.dart';
import 'package:plantify_app/data/import_csv.dart';
import 'package:plantify_app/models/plant.dart';
import 'package:plantify_app/models/soil.dart';

Future<Map<Soil, List<Plant>>> loadSoilAndPlants(String language) async {
  final soils = await loadSoilCSV(language);
  final plants = await loadPlantCSV(language);

  // Create a map to hold soil and its suitable plants
  Map<Soil, List<Plant>> soilPlantMap = {};

  // Populate the map
  for (var soil in soils) {
    final suitablePlants = getSuitablePlantsForSoil(soil, plants);
    soilPlantMap[soil] = suitablePlants;
  }

  return soilPlantMap;
}


List<Plant> getSuitablePlantsForSoil(Soil soil, List<Plant> plants) {
  return plants.where((plant) {
    final suitableSoilIds = plant.suitableSoil.split(',');
    return suitableSoilIds.contains(soil.id.toString());
  }).toList();
}
