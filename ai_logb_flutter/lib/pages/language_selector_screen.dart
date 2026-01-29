import 'package:ai_logb_flutter/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_logb_flutter/providers/language_provider.dart';
import 'package:ai_logb_flutter/pages/log_butler_page.dart';

class LanguageSelectorScreen extends StatefulWidget {
  const LanguageSelectorScreen({super.key});

  @override
  State<LanguageSelectorScreen> createState() => _LanguageSelectorScreenState();
}

class _LanguageSelectorScreenState extends State<LanguageSelectorScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _fadeController,
            curve: Curves.easeInOut,
          ),
        );

    _scaleAnimation =
        Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _scaleController,
            curve: Curves.elasticOut,
          ),
        );

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020713),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: Listenable.merge([_fadeAnimation, _scaleAnimation]),
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // App Logo/Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3F8CFF),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF3F8CFF,
                              ).withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.language,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Title
                      const Text(
                        'Choose Language',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 12),

                      // Subtitle
                      Text(
                        'Select your preferred language',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 60),

                      // Language Options
                      Consumer<LanguageProvider>(
                        builder: (context, languageProvider, child) {
                          return Column(
                            children: languageProvider.supportedLocales.map((
                              locale,
                            ) {
                              final isSelected =
                                  languageProvider.currentLocale.languageCode ==
                                  locale.languageCode;
                              final isRTL = languageProvider.isRTL(locale);

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _LanguageCard(
                                  locale: locale,
                                  isSelected: isSelected,
                                  isRTL: isRTL,
                                  languageName: languageProvider
                                      .getLanguageDisplayName(
                                        locale.languageCode,
                                      ),
                                  onTap: () async {
                                    await languageProvider.setLanguage(
                                      locale.languageCode,
                                    );

                                    // Navigate to main app
                                    if (context.mounted) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LogButlerPage(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LanguageCard extends StatefulWidget {
  final Locale locale;
  final bool isSelected;
  final bool isRTL;
  final String languageName;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.locale,
    required this.isSelected,
    required this.isRTL,
    required this.languageName,
    required this.onTap,
  });

  @override
  State<_LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<_LanguageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.95,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? const Color(0xFF3F8CFF).withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.isSelected
                      ? AppColors.button
                      : Colors.white.withValues(alpha: 0.1),
                  width: widget.isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                textDirection: widget.isRTL
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  // Language Flag/Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.isSelected
                          ? AppColors.button
                          : Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        _getLanguageFlag(widget.locale.languageCode),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Language Name
                  Expanded(
                    child: Text(
                      widget.languageName,
                      style: TextStyle(
                        color: widget.isSelected
                            ? AppColors.button
                            : AppColors.text,
                        fontSize: 18,
                        fontWeight: widget.isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      textDirection: widget.isRTL
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                    ),
                  ),

                  // Selection Indicator
                  if (widget.isSelected)
                    Icon(
                      Icons.check_circle,
                      color: AppColors.button,
                      size: 24,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'fr':
        return '🇫🇷';
      case 'zh':
        return '🇨🇳';
      case 'ar':
        return '🇸🇦';
      default:
        return '🌐';
    }
  }
}
