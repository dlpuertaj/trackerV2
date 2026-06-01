import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('light theme is not null', () {
      final theme = AppTheme.light;
      expect(theme, isNotNull);
    });

    test('light theme uses Material 3', () {
      final theme = AppTheme.light;
      expect(theme.useMaterial3, true);
    });

    test('light theme has a color scheme', () {
      final theme = AppTheme.light;
      expect(theme.colorScheme, isNotNull);
    });

    test('primaryColor constant is defined', () {
      expect(AppTheme.primaryColor, isNotNull);
    });

    test('light theme has text theme with headline, title, and body styles', () {
      final theme = AppTheme.light;
      expect(theme.textTheme.headlineMedium, isNotNull);
      expect(theme.textTheme.titleMedium, isNotNull);
      expect(theme.textTheme.bodyMedium, isNotNull);
    });

    test('light theme has button theme', () {
      final theme = AppTheme.light;
      expect(theme.buttonTheme, isNotNull);
    });

    test('light theme has input decoration theme', () {
      final theme = AppTheme.light;
      expect(theme.inputDecorationTheme, isNotNull);
    });
  });
}
