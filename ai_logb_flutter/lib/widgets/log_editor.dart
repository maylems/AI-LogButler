import 'package:flutter/material.dart';
import 'package:ai_logb_flutter/data/constants.dart';

/// Text editor widget for log input with line numbers
///
/// Provides a monospace editor with line numbering and clear functionality.
/// Handles long logs gracefully with proper scrolling and overflow management.
class LogEditor extends StatelessWidget {
  final TextEditingController controller;
  final int lineCount;

  const LogEditor({
    super.key,
    required this.controller,
    required this.lineCount,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // Set a maximum height to prevent pixel overflow
        constraints: const BoxConstraints(
          maxHeight: 400, // Maximum height to prevent overflow
        ),
        decoration: BoxDecoration(
          color: AppColors.container,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Main content with scrolling
            SingleChildScrollView(
              // Enable scrolling for long content
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Line numbers column with fixed width
                    Container(
                      width: 50, // Fixed width to prevent overflow
                      padding: const EdgeInsets.all(12),
                      color: Colors.black12,
                      child: SingleChildScrollView(
                        // Scroll line numbers independently if needed
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(
                            // Limit line numbers to prevent overflow
                            lineCount.clamp(1, 100), // Max 100 lines displayed
                            (i) => Text(
                              '${i + 1}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'monospace',
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Text input area
                    Expanded(
                      child: TextField(
                        controller: controller,
                        maxLines: null, // Allow unlimited lines
                        minLines: 8, // Minimum height for 8 lines
                        style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                          hintText: Contents.pasteLog(context),
                          hintStyle: const TextStyle(color: Colors.white24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Clear button positioned at top right
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.text.withValues(alpha: 0.8),
                    size: 18,
                  ),
                  onPressed: controller.clear,
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(
                    minWidth: 25,
                    minHeight: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
