import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify_app/models/plant.dart';
import 'package:plantify_app/models/soil.dart';
import 'package:plantify_app/screens/details_page.dart';

class PlantListWidget extends StatefulWidget {
  final Soil soil;

  const PlantListWidget({super.key, required this.soil});

  @override
  _PlantListWidgetState createState() => _PlantListWidgetState();
}

class _PlantListWidgetState extends State<PlantListWidget> {
  Future<List<Plant>> _loadCSV() async {
    final rawData = await rootBundle.loadString('assets/plant_data.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

    return listData.map((row) => Plant.fromCSV(row)).toList();
  }

  List<Plant> _getSuitablePlantsForSoil(Soil soil, List<Plant> plants) {
    return plants.where((plant) {
      final suitableSoilIds = plant.suitableSoil.split(',');
      return suitableSoilIds.contains(soil.id.toString());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadCSV(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Plant> plants = snapshot.data as List<Plant>;
          List<Plant> suitablePlants =
              _getSuitablePlantsForSoil(widget.soil, plants);

          return Column(
            children: suitablePlants.map((plant) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DetailsPage(plant: plant),
                      transitionDuration:
                          Duration.zero, // No animation duration
                      reverseTransitionDuration:
                          Duration.zero, // No reverse animation duration
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10), // Adjust vertical spacing here
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(plant.plantImg),
                        radius: 30.r,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        plant.plantNameTag,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF163020),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(
              child:
                  CircularProgressIndicator()); // or some other loading indicator
        }
      },
    );
  }
}
