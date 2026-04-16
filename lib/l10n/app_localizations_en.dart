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
  String get continueText => 'Continue';

  @override
  String get createVaultKey => 'Create Your Vault Key';

  @override
  String get drawNewPattern => 'Draw a new pattern';

  @override
  String get drawVaultKey => 'Draw your vault key';

  @override
  String get lynraSecurity => 'Lynra Security';

  @override
  String get min4Dots => 'Use at least 4 dots';

  @override
  String get onboardingDescription => 'Your data stays on your device.\n\nLynraGreyNote does not use servers, does not track you, and does not collect any information.\n\nEverything you save is encrypted and stored locally.\nYou are the only one who can access it.\n\nUse Secondary PIN or Biometrics for quick and secure access.\nEnable Vault Word to add an extra layer of privacy and hide your content when needed.';

  @override
  String get patternMismatch => 'Patterns did not match. Start again';

  @override
  String get privateByDesign => 'Private by Design';

  @override
  String get wrongPattern => 'Wrong pattern. Try again';

  @override
  String get unlock => 'Unlock';

  @override
  String get unlockVault => 'Unlock Vault';

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
  String get editEntry => 'Edit Entry';

  @override
  String get newEntry => 'New Entry';
}
