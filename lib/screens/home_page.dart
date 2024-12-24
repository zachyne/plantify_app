import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantify_app/components/app_bar.dart';
import 'package:plantify_app/components/home_button.dart';
import 'package:plantify_app/data/import_csv.dart';
import 'package:plantify_app/data/language_notifier.dart';
import 'package:plantify_app/data/predict_soil.dart';
import 'package:plantify_app/models/plant.dart';
import 'package:plantify_app/models/soil.dart';
import 'package:plantify_app/screens/about_page.dart';
import 'package:plantify_app/screens/about_us_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PredictSoil predictSoil = PredictSoil();
    final language = Provider.of<LanguageNotifier>(context).language;

    return Scaffold(
      appBar: const PlantifyAppBar(title: "Plantify", showBackButton: false),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/leaves_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  language == 'english'
                      ? 'What do you want to do?'
                      : 'Ano ang gusto mong gawin?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    color: const Color(0xFF163020),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                // Elevated Buttons
                ..._buildButtons(context, predictSoil),
                SizedBox(height: 15.h),
                Text(
                  language == 'english'
                      ? 'or read about'
                      : "o magbasa tungkol sa",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF163020),
                  ),
                ),
                SizedBox(height: 15.h),
                ..._buildReadAboutButtons(context),
                SizedBox(height: 100.h),
                _buildAboutUsRow(context),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const ToggleButton(),
    );
  }

  List<Widget> _buildButtons(BuildContext context, PredictSoil predictSoil) {
    final language = Provider.of<LanguageNotifier>(context).language;
    return [
      _buildElevatedButton(
          context,
          language == 'english' ? 'Capture Soil' : 'I-capture ang Soil',
          predictSoil),
      SizedBox(height: 5.h),
      _buildElevatedButton(
          context,
          language == 'english'
              ? 'Upload Soil Image'
              : 'Mag-Upload ng Imahe ng Soil',
          predictSoil),
    ];
  }

  List<Widget> _buildReadAboutButtons(BuildContext context) {
    return [
      _buildElevatedButton(context, 'Soils', null),
      SizedBox(height: 5.h),
      _buildElevatedButton(context, 'Plants', null),
    ];
  }

  Widget _buildElevatedButton(
      BuildContext context, String label, PredictSoil? predictSoil) {
    final language = Provider.of<LanguageNotifier>(context).language;
    return SizedBox(
      width: language == 'english' ? 180.w : 250.w,
      height: 45.h,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF163020),
          ),
          alignment: Alignment
              .center, // Ensures text is centered both vertically and horizontally
        ),
        onPressed: () async {
          if (label == 'Capture Soil' || label == 'I-capture ang Soil') {
            await predictSoil?.pickImage(context, ImageSource.camera);
          } else if (label == 'Upload Soil Image' ||
              label == 'Mag-Upload ng Imahe ng Soil') {
            await predictSoil?.pickImage(context, ImageSource.gallery);
          } else if (label == 'Soils') {
            List<Soil> soils = await loadSoilCSV(language);
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AboutPage(soils: soils),
                transitionDuration: const Duration(seconds: 0),
              ),
            );
          } else if (label == 'Plants') {
            List<Plant> plants = await loadPlantCSV(language);
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AboutPage(plants: plants),
                transitionDuration: const Duration(seconds: 0),
              ),
            );
          }
        },
        child: Text(
          label,
          style: TextStyle(
            color: const Color(0xFFEEF0E5),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
            height: 1.0, // Setting height to 1.0 to align vertically
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAboutUsRow(BuildContext context) {
    final language = Provider.of<LanguageNotifier>(context).language;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          language == 'english' ? 'want to know more ' : 'kilalanin mo kami, ',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 5.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const AboutUsPage(),
                transitionDuration: const Duration(seconds: 0),
              ),
            );
          },
          child: Text(
            language == 'english' ? 'about us' : 'pindutin ito',
            style: const TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
        Text(
          language == 'english' ? '?' : '!',
          style: const TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 5.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
