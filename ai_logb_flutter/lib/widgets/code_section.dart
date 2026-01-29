import 'package:flutter/material.dart';
import 'package:ai_logb_flutter/data/constants.dart';

class CodeSectionCard extends StatelessWidget {
  final String code;

  const CodeSectionCard({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: AppColors.text,
        ),
      ),
    );
  }
}
