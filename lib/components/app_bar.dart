import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlantifyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton; // New parameter to control the back button

  const PlantifyAppBar({
    super.key,
    required this.title,
    this.showBackButton =
        true, // Default is true, so the back button shows unless specified
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logos/plain_logo.png',
            height: 40,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF163020),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFEEF0E5),
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: showBackButton,
    );
  }

  // This is required to specify the size of the AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
