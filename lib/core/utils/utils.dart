import 'package:flutter/material.dart';

/// Utility class for responsive design calculations in Flutter apps.
class ResponsiveUtils {
  /// Calculates a responsive width based on a percentage of the screen width.
  /// [context]: The BuildContext to access MediaQuery.
  /// [percentage]: The percentage of the screen width (0.0 to 1.0).
  static double getResponsiveWidth(BuildContext context, double percentage) {
    assert(percentage >= 0.0 && percentage <= 1.0, 'Percentage must be between 0 and 1');
    return MediaQuery.of(context).size.width * percentage;
  }

  /// Calculates a responsive height based on a percentage of the screen height.
  /// [context]: The BuildContext to access MediaQuery.
  /// [percentage]: The percentage of the screen height (0.0 to 1.0).
  static double getResponsiveHeight(BuildContext context, double percentage) {
    assert(percentage >= 0.0 && percentage <= 1.0, 'Percentage must be between 0 and 1');
    return MediaQuery.of(context).size.height * percentage;
  }

  /// Returns a responsive padding value based on screen width.
  /// [context]: The BuildContext to access MediaQuery.
  /// [basePadding]: The base padding value to scale.
  static double getResponsivePadding(BuildContext context, double basePadding) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Scale padding based on screen width (e.g., larger screens get larger padding)
    return basePadding * (screenWidth / 375.0); // 375.0 as reference width (common for mobile)
  }

  /// Determines the number of grid columns based on screen width.
  /// [context]: The BuildContext to access MediaQuery.
  static int getGridColumnCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) return 4; // Desktop/large tablet
    if (screenWidth > 600) return 3;  // Small tablet
    return 2;                        // Phone
  }

  /// Checks if the device is considered a tablet based on screen width.
  /// [context]: The BuildContext to access MediaQuery.
  static bool isTablet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 600;
  }

  /// Checks if the device is considered a desktop based on screen width.
  /// [context]: The BuildContext to access MediaQuery.
  static bool isDesktop(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 1200;
  }

  /// Returns a responsive font size based on screen width.
  /// [context]: The BuildContext to access MediaQuery.
  /// [baseFontSize]: The base font size to scale.
  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Scale font size based on screen width (reference: 375.0)
    return baseFontSize * (screenWidth / 375.0).clamp(0.8, 1.5);
  }

  /// Returns a responsive aspect ratio for grid items based on screen size.
  /// [context]: The BuildContext to access MediaQuery.
  static double getResponsiveAspectRatio(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) return 1.2; // Wider items for desktop
    if (screenWidth > 600) return 1.1;  // Slightly wider for tablets
    return 1.0;                        // Square items for phones
  }

  /// Returns a responsive SizedBox for vertical spacing.
  /// [context]: The BuildContext to access MediaQuery.
  /// [baseHeight]: The base height to scale.
  static SizedBox verticalSpacing(BuildContext context, double baseHeight) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(height: baseHeight * (screenHeight / 812.0)); // 812.0 as reference height
  }

  /// Returns a responsive SizedBox for horizontal spacing.
  /// [context]: The BuildContext to access MediaQuery.
  /// [baseWidth]: The base width to scale.
  static SizedBox horizontalSpacing(BuildContext context, double baseWidth) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(width: baseWidth * (screenWidth / 375.0)); // 375.0 as reference width
  }
}