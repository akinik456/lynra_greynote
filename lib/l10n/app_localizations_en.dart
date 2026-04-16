// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get confirmPattern => 'Draw the same pattern again to confirm';

  @override
  String get createVaultKey => 'Create Your Vault Key';

  @override
  String get drawNewPattern => 'Draw a new pattern';

  @override
  String get lynraSecurity => 'Lynra Security';

  @override
  String get min4Dots => 'Use at least 4 dots';

  @override
  String get patternMismatch => 'Patterns did not match. Start again';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get settings => 'Settings';

  @override
  String get security => 'Security';

  @override
  String get vaultWord => 'Vault Word';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get unlock => 'Unlock';

  @override
  String get editEntry => 'Edit Entry';

  @override
  String get newEntry => 'New Entry';
}
