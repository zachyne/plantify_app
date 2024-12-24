// soil_predictor.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantify_app/data/import_csv.dart';
import 'package:plantify_app/data/language_notifier.dart';
import 'package:plantify_app/models/soil.dart';
import 'package:plantify_app/screens/not_soil_page.dart';
import 'package:plantify_app/screens/result_page.dart';
import 'package:provider/provider.dart';

class PredictSoil {
  File? filePath;
  String label = '';
  double confidence = 0.0;

  Future<void> loadModel(String modelPath, String labelPath) async {
    String? res = await Tflite.loadModel(
      model: modelPath,
      labels: labelPath,
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
    debugPrint(res ?? 'Model loading failed');
  }

  Future<void> classifyImage(String imagePath) async {
    var recognitions = await Tflite.runModelOnImage(
      path: imagePath,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );

    if (recognitions == null || recognitions.isEmpty) {
      debugPrint("Recognitions is Null");
      return;
    }

    label = recognitions[0]['label'].toString();
    confidence = (recognitions[0]['confidence'] * 100);
  }

  Future<void> predictSoil(BuildContext context, String imagePath) async {
  final language = Provider.of<LanguageNotifier>(context, listen: false).language;
  await loadModel("assets/models/soil_or_not_model.tflite", "assets/models/soilOrNot.txt");
  await classifyImage(imagePath);

  if (label == "Soil") {
    String soilModelPath = "assets/models/soil_type_final_model_try.tflite";
    String soilLabelPath = language == "tagalog" ? "assets/models/labelsModel_tagalog.txt" : "assets/models/labelsModel.txt";
    
    await loadModel(soilModelPath, soilLabelPath);
    await classifyImage(imagePath);

    // Debug print to ensure the model works
    debugPrint('Classified Soil Label: $label with Confidence: $confidence');

    // Load the soil data from the CSV file
    List<Soil> soils = await loadSoilCSV(language);

    // Debug print to ensure the CSV loaded
    debugPrint('Loaded Soils: ${soils.length}');

    // Ensure there is a soil match
    try {
      Soil predictedSoil = soils.firstWhere((soil) => soil.name == label);
      debugPrint('Matched Soil: ${predictedSoil.name}');

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ResultPage(
            imageFile: filePath!,
            label: label,
            confidence: confidence,
            predictedSoil: predictedSoil,
          ),
          transitionDuration: Duration.zero, 
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } catch (e) {
      // Log or handle the case where soil is not found in the CSV
      debugPrint('Error: No matching soil found for label: $label');
    }
  } else {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const NotSoil(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}


  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image == null) return;

    filePath = File(image.path);
    await predictSoil(context, image.path);
  }
}
