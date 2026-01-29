import 'package:flutter/material.dart';

class AppLocalizations {
  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'app_title': 'AI Log Butler',
      'app_description': 'Paste raw logs for instant structured analysis.',
      'analyze_log': 'Analyze Log',
      'analyzing': 'Analyzing...',
      'paste_log': 'Paste stack trace or log here...',
      'clear': 'Clear logs',
      'problem': 'Problem',
      'likely_cause': 'Likely Cause',
      'recommended_fix': 'Recommended Fix',
      'code_example': 'Code Example',
      'analyze_another': 'Analyze Another',
      'copy_results': 'Copy Results',
      'error': 'Error',
      'analysis_failed': 'Analysis Failed',
      'please_enter_log': 'Please enter some log text to analyze',
      'network_error': 'Network error: Unable to connect to server.',
      'server_timeout': 'Server timeout: Request took too long.',
      'server_error': 'Server error: Unable to process request.',
      'invalid_response': 'Invalid response from server.',
      'choose_language': 'Choose Language',
      'select_language': 'Select your preferred language',
      'log_type': 'Log Type',
    },
    'fr': {
      'app_title': 'AI Log Butler',
      'app_description':
          'Collez des logs bruts pour une analyse structurée instantanée.',
      'analyze_log': 'Analyser le Log',
      'analyzing': 'Analyse...',
      'paste_log': 'Collez la trace de la pile ou le log ici...',
      'clear': 'Effacer les logs',
      'problem': 'Problème',
      'likely_cause': 'Cause Probable',
      'recommended_fix': 'Solution Recommandée',
      'code_example': 'Exemple de Code',
      'analyze_another': 'Analyser un Autre',
      'copy_results': 'Copier les Résultats',
      'error': 'Erreur',
      'analysis_failed': 'Analyse Échouée',
      'please_enter_log': 'Veuillez entrer un texte de log à analyser',
      'network_error': 'Erreur réseau: Impossible de se connecter au serveur.',
      'server_timeout': 'Délai d\'attente serveur dépassé.',
      'server_error': 'Erreur serveur: Impossible de traiter la demande.',
      'invalid_response': 'Réponse invalide du serveur.',
      'choose_language': 'Choisir la Langue',
      'select_language': 'Sélectionnez votre langue préférée',
      'log_type': 'Type de Log',
    },
    'zh': {
      'app_title': 'AI 日志管家',
      'app_description': '粘贴原始日志以获得即时结构化分析。',
      'analyze_log': '分析日志',
      'analyzing': '分析中...',
      'paste_log': '在此粘贴堆栈跟踪或日志...',
      'clear': '清除日志',
      'problem': '问题',
      'likely_cause': '可能原因',
      'recommended_fix': '建议修复',
      'code_example': '代码示例',
      'analyze_another': '分析另一个',
      'copy_results': '复制结果',
      'error': '错误',
      'analysis_failed': '分析失败',
      'please_enter_log': '请输入要分析的日志文本',
      'network_error': '网络错误：无法连接到服务器。',
      'server_timeout': '服务器超时：请求耗时过长。',
      'server_error': '服务器错误：无法处理请求。',
      'invalid_response': '服务器响应无效。',
      'choose_language': '选择语言',
      'select_language': '选择您的首选语言',
      'log_type': '日志类型',
    },
    'ar': {
      'app_title': 'مسجل السجل AI',
      'app_description': 'لصق السجلات الخام للحصول على تحليل منظم فوري.',
      'analyze_log': 'تحليل السجل',
      'analyzing': 'جاري التحليل...',
      'paste_log': 'لصق تتبع المكدس أو السجل هنا...',
      'clear': 'مسح السجلات',
      'problem': 'المشكلة',
      'likely_cause': 'السبب المحتمل',
      'recommended_fix': 'الإصلاح الموصى به',
      'code_example': 'مثال الكود',
      'analyze_another': 'تحليل آخر',
      'copy_results': 'نسخ النتائج',
      'error': 'خطأ',
      'analysis_failed': 'فشل التحليل',
      'please_enter_log': 'يرجى إدخال نص السجل للتحليل',
      'network_error': 'خطأ في الشبكة: لا يمكن الاتصال بالخادم.',
      'server_timeout': 'انتهت مهلة الخادم: استغرق الطلب وقتاً طويلاً.',
      'server_error': 'خطأ في الخادم: لا يمكن معالجة الطلب.',
      'invalid_response': 'استجابة غير صالحة من الخادم.',
      'choose_language': 'اختر اللغة',
      'select_language': 'حدد لغتك المفضلة',
      'log_type': 'نوع السجل',
    },
  };

  static AppLocalizations of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return AppLocalizations._(locale);
  }

  AppLocalizations._(this._locale);

  final Locale _locale;

  String get(String key) {
    return _localizedValues[_locale.languageCode]?[key] ??
        _localizedValues['en']![key] ??
        key;
  }

  // Convenience getters
  String get appTitle => get('app_title');
  String get appDescription => get('app_description');
  String get analyzeLog => get('analyze_log');
  String get analyzing => get('analyzing');
  String get pasteLog => get('paste_log');
  String get clear => get('clear');
  String get problem => get('problem');
  String get likelyCause => get('likely_cause');
  String get recommendedFix => get('recommended_fix');
  String get codeExample => get('code_example');
  String get analyzeAnother => get('analyze_another');
  String get copyResults => get('copy_results');
  String get error => get('error');
  String get analysisFailed => get('analysis_failed');
  String get pleaseEnterLog => get('please_enter_log');
  String get networkError => get('network_error');
  String get serverTimeout => get('server_timeout');
  String get serverError => get('server_error');
  String get invalidResponse => get('invalid_response');
  String get chooseLanguage => get('choose_language');
  String get selectLanguage => get('select_language');
  String get logType => get('log_type');

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('fr'),
    Locale('zh'),
    Locale('ar'),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations._(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
