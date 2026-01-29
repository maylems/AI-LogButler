import 'dart:async';
import 'dart:io';

import 'package:ai_logb_client/ai_logb_client.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../localizations/app_localizations.dart';

/// Manages the state and logic for log analysis operations
///
/// This notifier handles the complete lifecycle of log analysis:
/// - Loading states during API calls
/// - Error handling and user feedback
/// - Result storage and retrieval
/// - Language-aware API communication
class LogAnalysisNotifier extends ChangeNotifier {
  bool _isLoading = false;
  LogProblem? _result;
  String? _error;

  /// Current loading state - true when analysis is in progress
  bool get isLoading => _isLoading;

  /// The most recent analysis result, null if no analysis has been completed
  LogProblem? get result => _result;

  /// Current error message, null if no error has occurred
  String? get error => _error;

  /// Updates the loading state and notifies listeners
  ///
  /// This is called at the beginning and end of API operations
  /// to update the UI accordingly (show/hide loading indicators)
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Stores a successful analysis result and clears any previous errors
  ///
  /// Called when the API returns a valid analysis. This method
  /// automatically stops loading and updates the UI with the new results.
  void setResult(LogProblem result) {
    _result = result;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  /// Stores an error message and clears any previous results
  ///
  /// Called when something goes wrong during analysis. This method
  /// automatically stops loading and shows the error to the user.
  void setError(String error) {
    _error = error;
    _result = null;
    _isLoading = false;
    notifyListeners();
  }

  /// Resets the notifier to its initial state
  ///
  /// Useful when starting a new analysis or clearing the current
  /// session. All state is cleared and listeners are notified.
  void reset() {
    _isLoading = false;
    _result = null;
    _error = null;
    notifyListeners();
  }

  /// Clears the current error message while preserving other state
  ///
  /// This is useful when the user dismisses an error message
  /// but we want to keep any existing results.
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Performs log analysis using the Gemini API
  ///
  /// This is the main method that coordinates the entire analysis process:
  /// 1. Validates input and gets the current language
  /// 2. Sets loading state for UI feedback
  /// 3. Calls the server API with language preference
  /// 4. Handles various types of errors appropriately
  /// 5. Updates state with results or errors
  ///
  /// Parameters:
  /// - logText: The raw log content to analyze
  /// - context: BuildContext for accessing localization and device locale
  ///
  /// The method is designed to be resilient - it handles network errors,
  /// timeouts, API issues, and malformed responses gracefully.
  Future<void> analyzeLog(String logText, BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;

    // Validate that we actually have some content to analyze
    if (logText.trim().isEmpty) {
      setError(l10n.pleaseEnterLog);
      return;
    }

    // Show loading state to the user
    setLoading(true);

    try {
      // Call the server with both the log content and user's language preference
      final response = await client.logAnalysis
          .analyzeLog(logText, language: languageCode)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException(l10n.serverTimeout);
            },
          );

      // Success! Store the results
      setResult(response);
    } on TimeoutException catch (e) {
      // Handle case where the server takes too long to respond
      setError('${l10n.serverTimeout}: ${e.toString()}');
    } on SocketException catch (e) {
      // Handle network connectivity issues
      setError('${l10n.networkError}: ${e.message}');
    } on HttpException catch (e) {
      // Handle server-side HTTP errors (5xx, 4xx status codes)
      setError('${l10n.serverError}: ${e.message}');
    } on FormatException catch (e) {
      // Handle cases where the server returns invalid JSON
      setError('${l10n.invalidResponse}: ${e.message}');
    } catch (e) {
      // Catch-all for any other unexpected errors
      setError('${l10n.analysisFailed}: ${e.toString()}');
    } finally {
      // Always ensure loading is turned off, even if something went wrong
      if (_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
