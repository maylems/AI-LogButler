import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages application language settings and persistence
///
/// This provider handles:
/// - Language selection and storage
/// - First-time launch detection
/// - Supported locale management
/// - Display name formatting for languages
///
/// Uses SharedPreferences to persist language choices across app restarts.
class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';

  // Currently selected locale for the application
  Locale _currentLocale = const Locale('en');

  // Flag to determine if this is the first time the app is launched
  bool _isFirstLaunch = true;

  /// Getters for the current state
  Locale get currentLocale => _currentLocale;
  bool get isFirstLaunch => _isFirstLaunch;

  /// List of supported locales in the application
  ///
  /// Each locale represents a language the app supports:
  /// - English (en): Default language
  /// - French (fr): French localization
  /// - Chinese (zh): Simplified Chinese
  /// - Arabic (ar): Arabic with RTL support
  List<Locale> get supportedLocales => const [
    Locale('en'), // English
    Locale('fr'), // French
    Locale('zh'), // Chinese
    Locale('ar'), // Arabic (RTL)
  ];

  /// Human-readable display names for each supported language
  ///
  /// Used in the language selection UI to show proper names
  /// in their native scripts where appropriate.
  Map<String, String> get languageNames => {
    'en': 'English',
    'fr': 'Français',
    'zh': '中文',
    'ar': 'العربية',
  };

  /// Initializes the provider by loading saved language preferences
  ///
  /// Called when the provider is first created. Attempts to load
  /// the previously saved language from SharedPreferences. If no
  /// language is saved, defaults to English and marks as first launch.
  LanguageProvider() {
    _loadLanguage();
  }

  /// Loads the saved language preference from device storage
  ///
  /// This method:
  /// 1. Gets SharedPreferences instance
  /// 2. Reads the saved language code
  /// 3. Updates the current locale if found
  /// 4. Sets first launch flag based on whether a preference exists
  ///
  /// Errors are handled gracefully - if loading fails, the app
  /// continues with default English settings.
  Future<void> _loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languageKey);

      if (languageCode != null) {
        // Found saved language - use it and mark as not first launch
        _currentLocale = Locale(languageCode);
        _isFirstLaunch = false;
      } else {
        // No saved language - this is first launch
        _isFirstLaunch = true;
      }
      notifyListeners();
    } catch (e) {
      // If loading fails, keep default settings and mark as first launch
      _isFirstLaunch = true;
      notifyListeners();
    }
  }

  /// Saves a new language preference and updates the current locale
  ///
  /// This method:
  /// 1. Saves the language code to SharedPreferences
  /// 2. Updates the current locale
  /// 3. Marks that this is no longer the first launch
  /// 4. Notifies all listeners of the change
  ///
  /// Parameters:
  /// - languageCode: The language code to save (en, fr, zh, ar)
  ///
  /// Errors are handled silently to prevent UI disruption.
  Future<void> setLanguage(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);

      _currentLocale = Locale(languageCode);
      _isFirstLaunch = false;
      notifyListeners();
    } catch (e) {
      // Handle error silently - the UI will continue with current language
    }
  }

  /// Determines if a given locale should use right-to-left text direction
  ///
  /// Currently only Arabic (ar) uses RTL layout. This method can be
  /// extended to support additional RTL languages in the future.
  ///
  /// Parameters:
  /// - locale: The locale to check for RTL support
  ///
  /// Returns: true if the locale should use RTL layout
  bool isRTL(Locale locale) {
    return locale.languageCode == 'ar';
  }

  /// Gets the display name for a language code
  ///
  /// Returns the human-readable name for the given language code.
  /// If the language code is not found, returns the uppercase version
  /// of the code as a fallback.
  ///
  /// Parameters:
  /// - languageCode: The language code to get the display name for
  ///
  /// Returns: Human-readable language name or fallback
  String getLanguageDisplayName(String languageCode) {
    return languageNames[languageCode] ?? languageCode.toUpperCase();
  }
}
