import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/constants.dart';
import '../localizations/app_localizations.dart';
import '../notifiers/log_analysis_notifier.dart';
import 'result_screen.dart';

class LoadingScreen extends StatefulWidget {
  final String logText;

  const LoadingScreen({super.key, required this.logText});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _analysisStarted = false;

  @override
  void initState() {
    super.initState();
    // Start analysis when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_analysisStarted) {
        _analysisStarted = true;
        final notifier = Provider.of<LogAnalysisNotifier>(
          context,
          listen: false,
        );
        notifier.analyzeLog(widget.logText, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LogAnalysisNotifier>(
        builder: (context, notifier, _) {
          // Auto-navigate to result when ready
          if (notifier.result != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ResultScreen(),
                  ),
                );
              }
            });
          }

          // Auto-close on error to show error on main page
          if (notifier.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Navigator.pop(context);
              }
            });
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: notifier.isLoading
                    ? CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.button,
                        ),
                      )
                    : const SizedBox(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context).analyzing,
                style: TextStyle(color: AppColors.text, fontSize: 16),
              ),
            ],
          );
        },
      ),
    );
  }
}
