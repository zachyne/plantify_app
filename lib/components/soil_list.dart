import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify_app/data/import_csv.dart';
import 'package:plantify_app/data/language_notifier.dart';
import 'package:plantify_app/models/plant.dart';
import 'package:plantify_app/models/soil.dart';
import 'package:plantify_app/screens/details_page.dart';
import 'package:provider/provider.dart';

class SoilListWidget extends StatefulWidget {
  final Plant plant;

  const SoilListWidget({super.key, required this.plant});

  @override
  _SoilListWidgetState createState() => _SoilListWidgetState();
}

class _SoilListWidgetState extends State<SoilListWidget> {
  List<Soil> _getSuitableSoilsForPlant(Plant plant, List<Soil> soils) {
    return soils.where((soil) {
      final suitableSoilIds = plant.suitableSoil.split(',');
      return suitableSoilIds.contains(soil.id.toString());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<LanguageNotifier>(context).language;
    return FutureBuilder<List<Soil>>(
      future:
          loadSoilCSV(language), // Use the function to load soil data from CSV
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Soil> soils = snapshot.data as List<Soil>;
          List<Soil> suitableSoils =
              _getSuitableSoilsForPlant(widget.plant, soils);

          return Column(
            children: suitableSoils.map((soil) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DetailsPage(soil: soil),
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
                        backgroundImage: AssetImage(soil.imagePath),
                        radius: 30.r,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        soil.name,
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
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Error loading soils')); // Error handling
        } else {
          return const Center(
              child: CircularProgressIndicator()); // Loading indicator
        }
      },
    );
  }
}
