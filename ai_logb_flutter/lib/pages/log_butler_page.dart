import 'package:ai_logb_flutter/widgets/button_analyze.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localizations/app_localizations.dart';
import '../notifiers/log_analysis_notifier.dart';
import 'loading_screen.dart';

import '../widgets/log_butler_header.dart';
import '../widgets/log_editor.dart';

/// Main application screen for log analysis
///
/// This is the primary interface where users:
/// - Input their log text for analysis
/// - See real-time error messages
/// - Navigate to the analysis process
/// - View loading states and results
///
/// The page uses Provider pattern to manage state and responds
/// to changes in the LogAnalysisNotifier automatically.
class LogButlerPage extends StatefulWidget {
  const LogButlerPage({super.key});

  @override
  State<LogButlerPage> createState() => _LogButlerPageState();
}

class _LogButlerPageState extends State<LogButlerPage> {
  // Controller for the text input field where users paste their logs
  final TextEditingController _controller = TextEditingController();

  // Tracks the number of lines in the text input for UI sizing
  int _lineCount = 1;

  @override
  void initState() {
    super.initState();

    // Listen to text changes to update the line count dynamically
    // This ensures the text field grows appropriately with content
    _controller.addListener(() {
      final lines = _controller.text.isEmpty
          ? 1
          : _controller.text.split('\n').length;
      if (lines != _lineCount) {
        setState(() => _lineCount = lines);
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LogAnalysisNotifier>(
          builder: (context, notifier, _) {
            // Main layout with header, input area, and action button
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  // App header with branding and navigation
                  const LogButlerHeader(),
                  const SizedBox(height: 24),

                  // Text input area for log content
                  LogEditor(
                    controller: _controller,
                    lineCount: _lineCount,
                  ),
                  const SizedBox(height: 24),

                  // Error message display (shown only when there's an error)
                  if (notifier.error != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.red.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Error header with icon and dismiss button
                          Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red[700],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context).error,
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              // Dismiss button to clear the error
                              GestureDetector(
                                onTap: () => notifier.clearError(),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red[700],
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Detailed error message
                          Text(
                            notifier.error!,
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Main action button to start analysis
                  AnalyzeButton(
                    isLoading: notifier.isLoading,
                    onPressed: () async {
                      // Clear any previous errors before starting new analysis
                      notifier.clearError();

                      // Validate that the user has actually entered some log text
                      if (_controller.text.trim().isEmpty) {
                        notifier.setError(
                          AppLocalizations.of(context).pleaseEnterLog,
                        );
                        return;
                      }

                      // Navigate to the loading screen while analysis runs
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, animation, _) =>
                              LoadingScreen(logText: _controller.text),
                          transitionsBuilder: (_, animation, _, child) {
                            // Smooth slide-in animation for the loading screen
                            final tween = Tween(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).chain(CurveTween(curve: Curves.easeInOut));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
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
