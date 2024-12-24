import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify_app/components/home_button.dart';
import 'package:plantify_app/data/language_notifier.dart';
import 'package:plantify_app/screens/home_page.dart';
import 'package:provider/provider.dart';

class NotSoil extends StatelessWidget {
  const NotSoil({super.key});

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<LanguageNotifier>(context).language;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Align items to the edges
          children: [
            Image.asset(
              'assets/images/logos/plain_logo.png',
              height: 40, // Adjust logo size as needed
            ),
          ],
        ),
        backgroundColor: const Color(0xFFEEF0E5),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_outlined,
              size: 200,
              color: Color(0xFF163020),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                language == 'english'
                    ? 'The image is not a soil'
                    : 'Ang larawan ay hindi lupa',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF163020),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              language == 'english'
                  ? "Give it another try?"
                  : "Subukan muli?",
              style: const TextStyle(color: Color(0xFF163020)),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250.w, // Set a fixed width (adjust as needed)
              height: 50.w,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color(0xFF163020), // Background color
                  ),
                  textStyle: WidgetStateProperty.all<TextStyle>(
                    TextStyle(
                      fontWeight:
                          FontWeight.w600, // Semi-bold (w600 is equivalent)
                      fontSize: 18.0.sp, // Optional: Set font size
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const HomePage(),
                      transitionDuration:
                          Duration.zero, // No animation duration
                      reverseTransitionDuration:
                          Duration.zero, // No reverse animation duration
                    ),
                  );
                },
                child: Text(
                  language == 'english'
                      ? 'Back to Home'
                      : 'Bumalik sa Home',
                  style: TextStyle(
                    color: const Color(0xFFEEF0E5),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0.sp,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
      floatingActionButton: const ToggleButton(),
    );
  }
}
