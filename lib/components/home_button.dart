import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:plantify_app/data/language_notifier.dart';
import 'package:provider/provider.dart';
import 'package:plantify_app/screens/home_page.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final languageNotifier = Provider.of<LanguageNotifier>(context);

    return SpeedDial(
      backgroundColor: const Color(0xFF163020),
      animatedIcon: AnimatedIcons.menu_close,
      overlayOpacity: 0.4,
      tooltip: 'Options',
      foregroundColor: const Color(0xFFEEF0E5),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.home, color: Color(0xFFEEF0E5)),
          backgroundColor: const Color(0xFF163020),
          label: 'Home',
          labelBackgroundColor: const Color(0xFF163020),
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
                transitionDuration: const Duration(seconds: 0),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.language, color: Color(0xFFEEF0E5)),
          backgroundColor: const Color(0xFF163020),
          label: languageNotifier.language == 'english'
              ? 'Change to Tagalog'
              : 'Bumalik sa English',
          labelBackgroundColor: const Color(0xFF163020),
          onTap: () {
            // Toggle the language and notify listeners
            languageNotifier.toggleLanguage();

            // Navigate back to HomePage after language change
            Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
                transitionDuration: const Duration(seconds: 0),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ],
    );
  }
}
