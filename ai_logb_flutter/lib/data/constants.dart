import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ai_logb_flutter/localizations/app_localizations.dart';

/// Text style definitions used throughout the application
///
/// Centralizes typography settings to ensure consistency
/// across all UI components and screens.
class TextStyles {
  /// Large title style for headers and main headings
  ///
  /// Used for prominent text like app titles and section headers.
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFFFFFF),
  );

  /// Smaller title style for sub-headers and card titles
  ///
  /// Used for secondary headings and card titles that need
  /// to be prominent but not as large as the main title.
  static const TextStyle smallTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

/// Color palette for the application
///
/// Defines all colors used in the UI to maintain visual consistency
/// and make theme changes easier to manage.
class AppColors {
  /// Error/danger color for critical issues and destructive actions
  static const Color danger = Color(0xFFf01414);

  /// Warning color for potential issues and caution states
  static const Color warning = Color(0xFFf0b114);

  /// Success color for positive feedback and completed actions
  static const Color success = Color(0xFF14f014);

  /// Primary brand color for buttons, links, and interactive elements
  static const Color button = Color(0xFF3F8CFF);

  /// Container background color for cards and panels
  static const Color container = Color(0xFF1E1E1E);

  /// Main application background color
  static const Color background = Color(0xFF020713);

  /// Default text color for readable content
  static const Color text = Color(0xFFFFFFFF);

  /// Error state color for validation and error messages
  static const Color error = Color(0xFFf01414);
}

/// Centralized content and asset references
///
/// Manages all text constants, asset paths, and localized content
/// to keep the codebase organized and maintainable.
class Contents {
  /// Application title from localization
  ///
  /// Returns the app name in the current language.
  static String appName(BuildContext context) =>
      AppLocalizations.of(context).appTitle;

  /// Analyze button text from localization
  ///
  /// Returns the text for the main analysis action button.
  static String appAnalyz(BuildContext context) =>
      AppLocalizations.of(context).analyzeLog;

  /// Tooltip text for clear action
  ///
  /// Returns the help text for clearing log content.
  static String tooltip(BuildContext context) =>
      AppLocalizations.of(context).clear;

  /// Placeholder text for log input field
  ///
  /// Returns the hint text shown in the log text area.
  static String pasteLog(BuildContext context) =>
      AppLocalizations.of(context).pasteLog;

  /// Path to the main application logo
  static String logo = 'assets/images/logo.png';

  /// Error severity label
  static String error = 'ERROR';

  /// Success message for completed analysis
  static String severityE = 'Critical Issue Found!';

  /// Success message for completed analysis
  static String severityW = 'Analysis completed successfully!';

  /// Problem section title from localization
  static String problem(BuildContext context) =>
      AppLocalizations.of(context).problem;

  /// Likely cause section title from localization
  static String likelyCause(BuildContext context) =>
      AppLocalizations.of(context).likelyCause;

  /// Recommended fix section title from localization
  static String recommendedFix(BuildContext context) =>
      AppLocalizations.of(context).recommendedFix;

  /// Code example section label
  static String codeExample = 'Code Example';

  /// Icon asset paths for different sections
  ///
  /// These SVG icons are used throughout the app for visual hierarchy.
  static String icon0 = 'assets/icons/icon0.svg';
  static String icon1 = 'assets/icons/icon1.svg';
  static String icon2 = 'assets/icons/icon2.svg';
  static String icon3 = 'assets/icons/icon3.svg';

  /// Analyze another button text from localization
  ///
  /// Used for the action button to start a new analysis.
  static String analyzeAnother(BuildContext context) =>
      AppLocalizations.of(context).analyzeAnother;

  /// Copy results button text from localization
  ///
  /// Used for the action button to copy analysis results.
  static String copyResults(BuildContext context) =>
      AppLocalizations.of(context).copyResults;

  /// Analyzing status text from localization
  ///
  /// Shown during the analysis process to indicate progress.
  static String analyzeLog(BuildContext context) =>
      AppLocalizations.of(context).analyzing;

  /// Application description from localization
  ///
  /// Returns the app description in the current language.
  static String appDescription(BuildContext context) =>
      AppLocalizations.of(context).appDescription;
}
