// result_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify_app/components/app_bar.dart';
import 'package:plantify_app/components/home_button.dart';
import 'package:plantify_app/data/import_csv.dart';
import 'package:plantify_app/data/language_notifier.dart';
import 'package:plantify_app/models/plant.dart';
import 'package:plantify_app/models/soil.dart';
import 'package:plantify_app/screens/details_page.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatelessWidget {
  final File imageFile;
  final String label;
  final double confidence;
  final Soil predictedSoil;

  const ResultPage({
    super.key,
    required this.imageFile,
    required this.label,
    required this.confidence,
    required this.predictedSoil,
  });

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<LanguageNotifier>(context).language;

    return Scaffold(
      appBar: const PlantifyAppBar(title: "Prediction Result"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      imageFile,
                      width: 120.w,
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150, // Set the width to fit your layout
                          child: Text(
                            label,
                            style: TextStyle(
                              color: const Color(0xFF163020),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true, // Enable text wrapping
                            overflow: TextOverflow
                                .visible, // Ensure overflow is handled
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          '${confidence.toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                language == 'english'
                    ? '${predictedSoil.name} Description'
                    : 'Deskripsyon ng ${predictedSoil.name}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF163020),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                predictedSoil.description,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
              Text(
                language == 'english'
                    ? '${predictedSoil.name} Amendments'
                    : 'Amendments ng ${predictedSoil.name}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF163020),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                predictedSoil.amendments,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
              Text(
                language == 'english'
                    ? 'Suitable Plants for ${predictedSoil.name}'
                    : 'Angkop na Tanim para sa ${predictedSoil.name}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF163020),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: loadPlantCSV(language),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Plant> plants = snapshot.data!;
                    List<Plant> suitablePlants =
                        getSuitablePlantsForSoil(predictedSoil, plants);

                    return Column(
                      children: suitablePlants.map((plant) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          plant.plantNameTag,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: const Color(0xFF163020),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  DetailsPage(plant: plant),
                                              transitionDuration: Duration
                                                  .zero, // No animation duration
                                              reverseTransitionDuration: Duration
                                                  .zero, // No reverse animation duration
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
                                            fontFamily: 'Poppins',
                                            decoration:
                                                TextDecoration.underline,
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
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: const ToggleButton(),
    );
  }
}
