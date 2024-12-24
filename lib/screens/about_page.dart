import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify_app/components/app_bar.dart';
import 'package:plantify_app/components/home_button.dart';
import 'package:plantify_app/data/language_notifier.dart';
import 'package:plantify_app/models/plant.dart';
import 'package:plantify_app/models/soil.dart';
import 'package:plantify_app/screens/details_page.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  final List<Soil>? soils;
  final List<Plant>? plants;
  final mainColor = const Color(0xFF163020);
  final mainFont = "Poppins";

  const AboutPage({super.key, this.soils, this.plants})
      : assert(soils != null || plants != null,
            'Either soils or plants must be provided');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PlantifyAppBar(title: "About"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          // Use ListView.separated instead of ListView.builder
          itemCount: soils != null ? soils!.length : plants!.length,
          itemBuilder: (context, index) {
            if (soils != null) {
              final soil = soils![index];
              return _buildSoilRow(context, soil); // Pass context
            } else {
              final plant = plants![index];
              return _buildPlantRow(context, plant); // Pass context
            }
          },
          separatorBuilder: (context, index) =>
              const SizedBox(height: 25), // Adds space between items
        ),
      ),
      floatingActionButton: const ToggleButton(),
    );
  }

  // Updated _buildSoilRow method
  Widget _buildSoilRow(BuildContext context, Soil soil) {
    final language = Provider.of<LanguageNotifier>(context).language;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(soil.imagePath),
          radius: 40.r,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      soil.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1, // Limit to one line to show ellipses
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: mainFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DetailsPage(soil: soil),
                          transitionDuration:
                              Duration.zero, // No animation duration
                          reverseTransitionDuration:
                              Duration.zero, // No reverse animation duration
                        ),
                      );
                    },
                    child: Text(
                      language == 'english'
                          ? 'view details >'
                          : 'mga detalye >',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                        fontFamily: mainFont,
                        decoration: TextDecoration.underline,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                soil.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: mainFont,
                  fontSize: 18.sp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

// Updated _buildPlantRow method
  Widget _buildPlantRow(BuildContext context, Plant plant) {
    final language = Provider.of<LanguageNotifier>(context).language;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(plant.plantImg),
          radius: 40.r,
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    // Use Flexible here
                    child: Text(
                      plant.plantNameTag,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1, // Limit to one line to show ellipses
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: mainFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DetailsPage(plant: plant),
                          transitionDuration:
                              Duration.zero, // No animation duration
                          reverseTransitionDuration:
                              Duration.zero, // No reverse animation duration
                        ),
                      );
                    },
                    child: Text(
                      language == 'english'
                          ? 'view details >'
                          : 'mga detalye >',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                        fontFamily: mainFont,
                        decoration: TextDecoration.underline,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                plant.plantDes,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black54,
                  fontFamily: mainFont,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
