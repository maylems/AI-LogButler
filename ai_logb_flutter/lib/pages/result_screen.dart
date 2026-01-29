import 'package:ai_logb_client/ai_logb_client.dart';
import 'package:ai_logb_flutter/data/constants.dart';
import 'package:ai_logb_flutter/localizations/app_localizations.dart';
import 'package:ai_logb_flutter/notifiers/log_analysis_notifier.dart';
import 'package:ai_logb_flutter/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// Displays the results of log analysis in a structured, user-friendly format
///
/// This screen shows:
/// - Detected log type (JavaScript, Python, etc.)
/// - Problem severity and analysis timestamp
/// - Detailed problem description
/// - Likely causes and recommended fixes
/// - Code examples when available
/// - Actions for copying results or analyzing new logs
///
/// The screen automatically handles navigation back when analysis is complete
/// and provides a comprehensive view of the AI-generated insights.
class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  /// Formats the analysis results into a clean, copyable text format
  ///
  /// This creates a structured text representation that users can
  /// easily copy and share or save for documentation purposes.
  ///
  /// Parameters:
  /// - log: The LogProblem object containing all analysis data
  ///
  /// Returns: Formatted string with all analysis information
  String getCopyText(LogProblem log) {
    return '''
Problem Identified:
${log.problem}

Likely Cause:
${log.likelyCause}

Recommended Fix:
${log.recommendedFix}

Code Example:
${log.codeExample ?? 'None'}

Analysis Summary:
- Severity: ${log.severity}
- Timestamp: ${log.timestamp}
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.button),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Analysis Results',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<LogAnalysisNotifier>(
          builder: (context, notifier, _) {
            final LogProblem? log = notifier.result;

            // Handle case where no analysis results are available
            if (log == null) {
              return const Center(
                child: Text(
                  'No analysis available',
                  style: TextStyle(color: AppColors.text),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Log type detection display at the top
                  if (log.logType != null && log.logType!.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.button.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        color: AppColors.button.withValues(alpha: 0.1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.code,
                                color: AppColors.button,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context).logType,
                                style: TextStyle(
                                  color: AppColors.text.withValues(alpha: 0.7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            log.logType!,
                            style: TextStyle(
                              color: AppColors.button,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Severity indicator and timestamp
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          getSeverityIcon(log.severity),
                          color: getSeverityColor(log.severity),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getSeverityMessage(log.severity),
                                style: TextStyle(
                                  color: getSeverityColor(log.severity),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Analyzed at: ${log.timestamp}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.text.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Problem description section
                  if (log.problem.isNotEmpty)
                    SectionCard(
                      title: Contents.problem(context),
                      content: log.problem,
                      icon: Contents.icon0,
                      color: AppColors.danger,
                    ),

                  // Likely cause section
                  if (log.likelyCause.isNotEmpty)
                    SectionCard(
                      title: Contents.likelyCause(context),
                      content: log.likelyCause,
                      icon: Contents.icon2,
                      color: AppColors.warning,
                    ),

                  // Recommended fix section (includes code example if available)
                  if (log.recommendedFix.isNotEmpty)
                    SectionCard(
                      title: Contents.recommendedFix(context),
                      content: log.recommendedFix,
                      icon: Contents.icon3,
                      color: AppColors.success,
                      code: log.codeExample,
                    ),

                  const SizedBox(height: 16),

                  // Action buttons for user interaction
                  Row(
                    children: [
                      // Button to analyze another log
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            notifier.reset();
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.button),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            Contents.analyzeAnother(context),
                            style: TextStyle(
                              color: AppColors.button,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Button to copy results to clipboard
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final messenger = ScaffoldMessenger.of(context);
                            final copyText = Contents.copyResults(context);

                            // Copy formatted results to clipboard
                            await Clipboard.setData(
                              ClipboardData(text: getCopyText(log)),
                            );

                            if (!mounted) return;

                            // Show confirmation message
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(copyText),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.button,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            Contents.copyResults(context),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Returns appropriate icon for different severity levels
///
/// Maps severity strings to Material Design icons for visual
/// representation of the problem seriousness.
IconData getSeverityIcon(String? severity) {
  switch (severity) {
    case 'ERROR':
      return Icons.error;
    case 'WARNING':
      return Icons.warning_amber_rounded;
    default:
      return Icons.info_outline;
  }
}

/// Returns appropriate color for different severity levels
///
/// Uses semantic colors that match the severity:
/// - Red for errors (critical issues)
/// - Orange for warnings (potential issues)
/// - Green for info (no critical issues)
Color getSeverityColor(String? severity) {
  switch (severity) {
    case 'ERROR':
      return AppColors.danger;
    case 'WARNING':
      return AppColors.warning;
    default:
      return AppColors.success;
  }
}

/// Returns user-friendly messages for different severity levels
///
/// Provides clear, human-readable descriptions that help users
/// understand the seriousness of the detected issue.
String getSeverityMessage(String? severity) {
  switch (severity) {
    case 'ERROR':
      return 'Critical issue detected';
    case 'WARNING':
      return 'Potential issue detected';
    default:
      return 'No critical issues found';
  }
}
