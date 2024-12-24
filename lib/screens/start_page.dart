import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify_app/screens/home_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: const Color(0xFF163020),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0.sp,
                    ),
                  ),
                  const Text(
                    "Know your soil, Know your plants",
                    style: TextStyle(
                      color: Color(0xFF163020),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 30),
                  Image.asset(
                    'assets/images/logos/logo_with_name.png',
                    height: 90.h,
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: 200.w, // Set a fixed width (adjust as needed)
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
                        'Get Started',
                        style: TextStyle(
                          color: const Color(0xFFEEF0E5),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0.sp,
                        ),
                      ),
                    ),
                  ),

                ]
              )
          )
      );
  }
}
