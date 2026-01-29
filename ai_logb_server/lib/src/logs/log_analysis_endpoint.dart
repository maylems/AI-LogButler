import 'dart:convert';

import 'package:dartantic_ai/dartantic_ai.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Handles log analysis requests using Google's Gemini AI
///
/// This endpoint processes raw log text and returns structured analysis
/// including problem identification, likely causes, and recommended fixes.
/// The analysis is performed in the user's preferred language when specified.
class LogAnalysisEndpoint extends Endpoint {
  /// Simple health check for the endpoint
  ///
  /// Returns a confirmation message to verify the endpoint is working
  /// and can be reached by the client application.
  Future<String> test(Session session) async {
    return 'LogAnalysisEndpoint is working!';
  }

  /// Analyzes log content using Gemini AI and returns structured results
  ///
  /// This method performs the core log analysis functionality:
  /// 1. Validates the Gemini API key from server configuration
  /// 2. Sets up the AI agent with appropriate model configuration
  /// 3. Determines the response language based on user preference
  /// 4. Sends the log to Gemini with a structured prompt
  /// 5. Parses the JSON response and returns a LogProblem object
  ///
  /// Parameters:
  /// - session: Serverpod session containing configuration and logging
  /// - logContent: The raw log text to be analyzed
  /// - language: Optional language code (en, fr, zh, ar) for response localization
  ///
  /// Returns: LogProblem object with structured analysis results
  ///
  /// Throws: Exception if API key is missing or other processing errors occur
  Future<LogProblem> analyzeLog(
    Session session,
    String logContent, {
    String? language,
  }) async {
    try {
      // Get the Gemini API key from server configuration
      // This key should be stored in passwords.yaml for security
      final geminiApiKey = session.passwords['geminiApiKey'];
      if (geminiApiKey == null || geminiApiKey.isEmpty) {
        throw Exception('Gemini API key not found in passwords.yaml');
      }

      // Initialize the Gemini AI agent with our API key
      // Using gemini-2.5-flash-lite for fast, cost-effective analysis
      final agent = Agent.forProvider(
        GoogleProvider(apiKey: geminiApiKey),
        chatModelName: 'gemini-2.5-flash-lite',
      );

      // Set up language-specific instructions for the AI response
      // This ensures the analysis is returned in the user's preferred language
      String languageInstruction = '';
      String responseLanguage = 'English';

      switch (language) {
        case 'fr':
          languageInstruction =
              'IMPORTANT: Respond in FRENCH. All analysis text must be in French language.';
          responseLanguage = 'French';
          break;
        case 'zh':
          languageInstruction =
              'IMPORTANT: Respond in CHINESE (中文). All analysis text must be in Chinese language.';
          responseLanguage = 'Chinese';
          break;
        case 'ar':
          languageInstruction =
              'IMPORTANT: Respond in ARABIC. All analysis text must be in Arabic language.';
          responseLanguage = 'Arabic';
          break;
        default:
          // Default to English for any unsupported or null language codes
          languageInstruction =
              'IMPORTANT: Respond in ENGLISH. All analysis text must be in English language.';
          responseLanguage = 'English';
      }

      // Construct a detailed prompt for Gemini to ensure consistent, structured output
      // The prompt includes strict formatting requirements to ensure we get valid JSON
      final prompt =
          '''
You are an expert software log analyzer with deep knowledge of various log formats and programming languages.

$languageInstruction

CRITICAL RULES:
- Return ONLY raw JSON
- NO markdown
- NO explanation
- NO comments
- NO text before or after JSON
- All text fields (problem, likelyCause, recommendedFix) must be in $responseLanguage
- The logType field MUST be populated with one of the specified values

The JSON MUST be parsable by json.decode() in Dart.

Schema:
{
  "problem": "string (in $responseLanguage)",
  "likelyCause": "string (in $responseLanguage)",
  "recommendedFix": "string (in $responseLanguage)",
  "codeExample": null,
  "severity": "ERROR | WARNING | INFO",
  "logType": "string (MUST be one of: 'JavaScript', 'Python', 'Java', 'C#', 'Go', 'Rust', 'SQL', 'Bash', 'Docker', 'Nginx', 'Apache', 'System', 'Application', 'Database', 'Network', 'Other')"
}

ANALYSIS INSTRUCTIONS:
1. FIRST: Identify the log type by examining the content, syntax, error patterns, and context
2. Look for specific indicators:
   - JavaScript: console.log, TypeError, ReferenceError, Node.js errors, browser errors
   - Python: Traceback, ImportError, ValueError, Python syntax
   - Java: Exception, StackTrace, Java package names, JVM errors
   - C#: .NET exceptions, System namespace, C# syntax
   - Go: panic, go routines, Go package structure
   - Rust: panic!, Result types, Cargo errors
   - SQL: SELECT, INSERT, UPDATE, database errors
   - Bash: shell commands, bash syntax, exit codes
   - Docker: Docker commands, container errors, Dockerfile syntax
   - Nginx: nginx configuration, HTTP status codes, access logs
   - Apache: httpd.conf, Apache modules, access logs
   - System: OS logs, kernel messages, system services
   - Application: application-specific logs, custom formats
   - Database: database queries, connection errors, transaction logs
   - Network: network protocols, connection issues, packet logs
3. If no specific type matches, use "Other"
4. Provide detailed technical analysis in $responseLanguage

Analyze this log and produce a comprehensive technical analysis:

$logContent
''';

      // Send the prompt to Gemini and get the response
      final response = await agent.send(prompt);

      // Extract clean JSON from the response (Gemini sometimes adds extra text)
      final cleanedJson = _extractJson(response.output);

      // Parse the JSON response into a Map
      final Map<String, dynamic> map = json.decode(cleanedJson);

      // Add timestamp if not provided by the AI
      map['timestamp'] ??= DateTime.now().toIso8601String();

      // Convert the Map to our LogProblem object
      return LogProblem.fromJson(map);
    } catch (e, stack) {
      // Log the error for debugging purposes
      session.log('LogAnalysis error: $e');
      session.log(stack.toString());

      // Return a fallback error response instead of crashing
      // This ensures the client always gets a response, even on errors
      return LogProblem(
        problem: 'AI analysis failed',
        likelyCause: e.toString(),
        recommendedFix: 'Check Gemini API key, network, and AI JSON output',
        codeExample: null,
        severity: 'ERROR',
        timestamp: DateTime.now(),
        logType: 'Other', // Default log type for error cases
      );
    }
  }

  /// Helper method to extract clean JSON from Gemini's response
  ///
  /// Gemini sometimes includes extra text or formatting around the JSON.
  /// This method finds the first JSON object in the response and extracts it.
  ///
  /// Parameters:
  /// - input: Raw response text from Gemini
  ///
  /// Returns: Clean JSON string that can be parsed by json.decode()
  ///
  /// Throws: FormatException if no valid JSON object is found
  String _extractJson(String input) {
    final start = input.indexOf('{');
    final end = input.lastIndexOf('}');

    if (start == -1 || end == -1 || end <= start) {
      throw FormatException('No valid JSON object found in AI response');
    }

    return input.substring(start, end + 1);
  }
}
