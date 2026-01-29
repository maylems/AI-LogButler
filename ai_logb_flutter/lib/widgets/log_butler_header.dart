import 'package:flutter/material.dart';
import 'package:ai_logb_flutter/data/constants.dart';

/// Header widget for the main log analysis screen
///
/// Displays the app logo, title, and description in a vertical layout.
/// The logo is positioned at the top center above the title text.
class LogButlerHeader extends StatelessWidget {
  const LogButlerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Logo at the top center
            Positioned(
              top: -16,
              left: 0,
              right: 0,
              child: Center(
                child: Image(
                  image: AssetImage(Contents.logo),
                  width: 120,
                  height: 120,
                ),
              ),
            ),

            // Title and description below the logo with small spacing
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App title
                  Text(
                    Contents.appName(context),
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // App description
                  Text(
                    Contents.appDescription(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
