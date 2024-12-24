import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify_app/components/app_bar.dart';
import 'package:plantify_app/components/home_button.dart';
import 'package:plantify_app/components/plant_list.dart';
import 'package:plantify_app/components/soil_list.dart';
import 'package:plantify_app/data/language_notifier.dart';
import 'package:plantify_app/models/plant.dart';
import 'package:plantify_app/models/soil.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final Soil? soil;
  final Plant? plant;

  final Color mainColor = const Color(0xFF163020);
  final String mainFont = "Poppins";
  final EdgeInsets padding = const EdgeInsets.all(16.0);

  const DetailsPage({super.key, this.soil, this.plant});

  @override
  Widget build(BuildContext context) {
    if (soil == null && plant == null) {
      return const Scaffold(
        body: Center(child: Text('No details available.')),
      );
    }

    return Scaffold(
      appBar: PlantifyAppBar(
        title: soil != null ? soil!.name : plant?.plantNameTag ?? 'Details',
      ),
      body: Center(
        child: soil != null
            ? _buildSoilDetails(context, soil!)
            : _buildPlantDetails(context, plant!),
      ),
      floatingActionButton: const ToggleButton(),
    );
  }

  // Soil details widget
  Widget _buildSoilDetails(BuildContext context, Soil soil) {
    final language = Provider.of<LanguageNotifier>(context).language;
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: double.infinity.w, // Full width of the screen
              height: 300.h, // Set the height to 300 pixels
              child: Stack(
                children: [
                  // Background image
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(soil.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Green gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          const Color(0xFF163020).withOpacity(
                              0.9), // Green color with opacity at the bottom
                          Colors.transparent, // Transparent at the top
                        ],
                      ),
                    ),
                  ),
                  // Positioned text widgets for title
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 300, // Set the width to fit your layout
                          child: Text(
                            soil.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 44.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true, // Enable text wrapping
                            overflow: TextOverflow
                                .visible, // Ensure overflow is handled
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: padding,
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildTextTitle(
                    language == 'english' ? "DESCRIPTION" : "DESKRIPSYON", 24,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 20),
                _buildTextDescription(soil.description, 20),
                const SizedBox(height: 50),
                _buildTextTitle(
                    language == 'english'
                        ? '${soil.name} Amendments'
                        : 'Amendments ng ${soil.name}',
                    24,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 20),
                _buildTextDescription(soil.amendments, 20),
                const SizedBox(height: 50),
                _buildTextTitle(
                    language == 'english'
                        ? 'Suitable Crops / Plants'
                        : 'Mga angkop na tanim para sa ${soil.name}',
                    24,
                    fontWeight: FontWeight.bold),
                // the suitable crops and plants should be put here
                PlantListWidget(soil: soil),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Plant details widget
  Widget _buildPlantDetails(BuildContext context, Plant plant) {
    final language = Provider.of<LanguageNotifier>(context).language;
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: double.infinity.w, // Full width of the screen
              height: 300.h, // Set the height to 300 pixels
              child: Stack(
                children: [
                  // Background image
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(plant.plantImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Green gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          const Color(0xFF163020).withOpacity(
                              0.9), // Green color with opacity at the bottom
                          Colors.transparent, // Transparent at the top
                        ],
                      ),
                    ),
                  ),
                  // Positioned text widgets for title
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.plantNameTag,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 44.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          plant
                              .plantNameEng, // If needed, replace this with a suitable subtitle
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: padding,
            child: Column(
              children: [
                _buildTextTitle(
                    language == 'english' ? "DESCRIPTION" : "DESKRIPSYON", 24,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 30),
                _buildTextDescription(plant.plantDes, 20),
                const SizedBox(height: 30),
                _buildTextTitle(
                    language == 'english'
                        ? "Basic Farming Guide"
                        : "Pangunahing Gabay sa Pagtatanim",
                    24,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 30),
                _buildTextTitle(
                    language == 'english'
                        ? "DEPTHS TO PLANT"
                        : "KALALIMAN SA PAGTATANIM",
                    20,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 20),
                _buildTextDescription(plant.plantDep, 20),
                const SizedBox(height: 30),
                _buildTextTitle(
                    language == 'english'
                        ? "SPACING REQUIREMENTS"
                        : "KAILANGAN NA ESPASYO",
                    20,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 20),
                _buildTextDescription(plant.plantSpacing, 20),
                const SizedBox(height: 30),
                _buildTextTitle(
                    language == 'english'
                        ? "WATERING NEEDS"
                        : "KAILANGAN NG PAGDILIG",
                    20,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 20),
                _buildTextDescription(plant.plantWater, 20),
                const SizedBox(height: 30),
                _buildTextTitle(
                    language == 'english'
                        ? "SUITABLE SOIL TYPES"
                        : "MGA ANGKOP NA URI NG LUPA",
                    20,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 20),
                SoilListWidget(plant: plant),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextDescription(String text, double fontSize,
      {FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        height: 1.0,
        color: mainColor,
        fontFamily: mainFont,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget _buildTextTitle(String text, double fontSize,
      {FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        height: 1.0,
        color: mainColor,
        fontFamily: mainFont,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}
