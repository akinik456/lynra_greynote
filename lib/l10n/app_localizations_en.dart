// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get add => 'Add';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get addFirstSecureEntry => 'Tap the + button to add your first secure entry.';

  @override
  String get cancel => 'Cancel';

  @override
  String get collection => 'Collection';

  @override
  String get collectionExample => 'e.g. Mom';

  @override
  String get confirmPattern => 'Draw the same pattern again to confirm';

  @override
  String get confirmPin => 'Confirm PIN';

  @override
  String get continueText => 'Continue';

  @override
  String get createVaultKey => 'Create Your Vault Key';

  @override
  String get delete => 'Delete';

  @override
  String get deleteCollection => 'Delete Collection';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'Delete \"$name\"?\n\nAll entries will be permanently deleted.';
  }

  @override
  String get deleteEntry => 'Delete entry';

  @override
  String deleteEntryConfirm(Object name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get drawNewPattern => 'Draw a new pattern';

  @override
  String get drawVaultKey => 'Draw your vault key';

  @override
  String get editEntry => 'Edit Entry';

  @override
  String get enterPin => 'Enter PIN';

  @override
  String get lynraSecurity => 'Lynra Security';

  @override
  String get max5Collections => 'Maximum 5 collections allowed';

  @override
  String get min4Dots => 'Use at least 4 dots';

  @override
  String get myVault => 'My Vault';

  @override
  String get newCollection => 'New Collection';

  @override
  String get newEntry => 'New Entry';

  @override
  String get noEntriesYet => 'No entries yet';

  @override
  String get noUsername => 'No username';

  @override
  String get onboardingDescription => 'Your data stays on your device.\n\nLynraGreyNote does not use servers, does not track you, and does not collect any information.\n\nEverything you save is encrypted and stored locally.\nYou are the only one who can access it.\n\nUse Secondary PIN or Biometrics for quick and secure access.\nEnable Vault Word to add an extra layer of privacy and hide your content when needed.';

  @override
  String get patternMismatch => 'Patterns did not match. Start again';

  @override
  String get pinMustBe6Digits => 'PIN must be 6 digits';

  @override
  String get pinSaved => 'PIN saved';

  @override
  String get pinsDoNotMatch => 'PINs do not match';

  @override
  String get privateByDesign => 'Private by Design';

  @override
  String get save => 'Save';

  @override
  String get savePin => 'Save PIN';

  @override
  String get security => 'Security';

  @override
  String get settings => 'Settings';

  @override
  String get setPin => 'Set PIN';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'items',
      one: 'item',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'Vault Word';

  @override
  String get wrongPattern => 'Wrong pattern. Try again';

  @override
  String get wrongPin => 'Wrong PIN';

  @override
  String get unlock => 'Unlock';

  @override
  String get unlockContent => 'Unlock Content';

  @override
  String get unlockVault => 'Unlock Vault';

  @override
  String get untitled => 'Untitled';

  @override
  String updatedDate(Object date) {
    return 'Updated $date';
  }
}
