import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify_app/components/app_bar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PlantifyAppBar(title: "About Us"),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset(
                'assets/images/logos/logo_with_name.png',
                height: 100, // Adjust logo size as needed
              ),
              const SizedBox(height: 20),
              Text(
                'The Team',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24.0.sp,
                  color: const Color(0xFF163020),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'We are a group of students from Biliran Province State University who are passionate of creating an innovation that can help people love farming through using our expertise and skills as Computer Science students.',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15.0.sp,
                      color: const Color(0xFF163020),
                      height: 1.2),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Members',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0.sp,
                  color: const Color(0xFF163020),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      // Jansen
                      Image.asset(
                        'assets/images/aboutus/jansen.png',
                        height: 100, // Adjust logo size as needed
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'JANSEN C. SOLAYAO',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0.sp,
                          color: const Color(0xFF163020),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Team Leader',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.0.sp,
                            color: const Color(0xFF163020),
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),

                  // Jeneth
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/aboutus/jeneth.png',
                        height: 100, // Adjust logo size as needed
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'JENETH M. ESTRELLER',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0.sp,
                          color: const Color(0xFF163020),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Field Researcher',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.0.sp,
                            color: const Color(0xFF163020),
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      // MJ
                      Image.asset(
                        'assets/images/aboutus/mj.png',
                        height: 100, // Adjust logo size as needed
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'MARC JASON C. CATABAY',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0.sp,
                          color: const Color(0xFF163020),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Field Researcher',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.0.sp,
                            color: const Color(0xFF163020),
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // Cyrine
                      Image.asset(
                        'assets/images/aboutus/cycy.png',
                        height: 100, // Adjust logo size as needed
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'CYRINE B. MALESIDO',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0.sp,
                          color: const Color(0xFF163020),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Developer',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.0.sp,
                            color: const Color(0xFF163020),
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Adviser',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0.sp,
                  color: const Color(0xFF163020),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  // Sir J
                  Image.asset(
                    'assets/images/aboutus/sir.png',
                    height: 200, // Adjust logo size as needed
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'SIR EVAN',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.0.sp,
                      color: const Color(0xFF163020),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Thesis Adviser',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.0.sp,
                        color: const Color(0xFF163020),
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'About Plantify',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0.sp,
                  color: const Color(0xFF163020),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'This mobile application is created as a requirement for the completion of our thesis project. This will not be possible without the help of our adviser, our school, and our university.',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15.0.sp,
                      color: const Color(0xFF163020),
                      height: 1.2),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Acknowledgement',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0.sp,
                  color: const Color(0xFF163020),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/aboutus/stcs.png',
                    height: 150, // Adjust logo size as needed
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/images/aboutus/bipsu.png',
                    height: 150, // Adjust logo size as needed
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'All Rights Reserved 2024',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.0.sp,
                  color: const Color(0xFF163020),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
