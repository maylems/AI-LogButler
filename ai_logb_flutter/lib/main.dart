import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ai_logb_client/ai_logb_client.dart';
import 'package:provider/provider.dart';
import 'data/constants.dart';
import 'pages/log_butler_page.dart';
import 'pages/language_selector_screen.dart';
import 'notifiers/log_analysis_notifier.dart';
import 'providers/language_provider.dart';
import 'localizations/app_localizations.dart';

/// Global client instance for Serverpod communication
///
/// This client is initialized once at app startup and used throughout
/// the application for all server communication including log analysis.
late final Client client;

/// Application entry point
///
/// Initializes the Flutter app and sets up the Serverpod client connection.
/// The client connects to the Serverpod server for AI log analysis functionality.
void main() async {
  // Ensure Flutter bindings are initialized before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the Serverpod client with server URL
  // This establishes the connection to our backend API
  client = Client('http://192.168.1.6:8080/');

  // Run the Flutter application
  runApp(const MyApp());
}

/// Root widget of the application
///
/// Sets up the application structure with:
/// - Provider state management for language and analysis
/// - Material Design theme and localization
/// - Navigation routing based on first launch status
/// - Multi-language support with proper delegates
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Set up state management providers
      providers: [
        // Manages log analysis state and API communication
        ChangeNotifierProvider(create: (_) => LogAnalysisNotifier()),

        // Manages language preferences and app localization
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],

      // Build the app based on current language settings
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          return MaterialApp(
            title: 'AI Log Butler',
            debugShowCheckedModeBanner: false,

            // Application theme configuration
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.button),
              scaffoldBackgroundColor: AppColors.background,
            ),

            // Localization settings
            locale: languageProvider.currentLocale,
            supportedLocales: languageProvider.supportedLocales,
            localizationsDelegates: const [
              // Custom app localization for UI text
              AppLocalizations.delegate,

              // Standard Flutter localization delegates
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // Initial screen based on first launch status
            home: _getInitialScreen(languageProvider),
          );
        },
      ),
    );
  }

  /// Determines which screen to show on app startup
  ///
  /// If this is the first time the app is launched, shows the language
  /// selection screen so users can choose their preferred language.
  /// Otherwise, goes directly to the main log analysis screen.
  ///
  /// Parameters:
  /// - languageProvider: Instance containing first launch status
  ///
  /// Returns: The appropriate initial screen widget
  Widget _getInitialScreen(LanguageProvider languageProvider) {
    return languageProvider.isFirstLaunch
        ? const LanguageSelectorScreen()
        : const LogButlerPage();
  }
}
