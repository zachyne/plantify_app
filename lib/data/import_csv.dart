import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:plantify_app/models/plant.dart';
import 'package:plantify_app/models/soil.dart';

Future<List<Plant>> loadPlantCSV(String language) async {
  String csvFilePath;

  // Determine which CSV file to load based on the language
  if (language == 'tagalog') {
    csvFilePath = 'assets/plant_data_tagalog.csv';
  } else {
    csvFilePath = 'assets/plant_data.csv';
  }
 
  final rawData = await rootBundle.loadString(csvFilePath);
  List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

  return listData.map((row) => Plant.fromCSV(row)).toList();
}

Future<List<Soil>> loadSoilCSV(String language) async {
  String csvFilePath;

  // Determine which CSV file to load based on the language
  if (language == 'tagalog') {
    csvFilePath = 'assets/soil_data_tagalog.csv';
  } else {
    csvFilePath = 'assets/soil_data.csv';
  }

  final rawData = await rootBundle.loadString(csvFilePath);
  List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

  return listData.map((row) => Soil.fromCSV(row)).toList();
}

List<Plant> getSuitablePlantsForSoil(Soil soil, List<Plant> plants) {
  return plants.where((plant) {
    final suitableSoilIds = plant.suitableSoil.split(',');
    return suitableSoilIds.contains(soil.id.toString());
  }).toList();
}
