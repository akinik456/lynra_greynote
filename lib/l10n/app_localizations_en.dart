// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get attachmentRemoved => 'Attachment removed';

  @override
  String get viewAttachment => 'View Attachment';

  @override
  String get addAttachment => 'Add Attachment';

  @override
  String get attachmentReady => 'Attachment ready';

  @override
  String get attachmentTooLarge => 'Max 2MB allowed';

  @override
  String get search => 'Search';

  @override
  String get unlockToSearch => 'Unlock to search';

  @override
  String get limitReached => 'Limit reached';

  @override
  String get freeLimitEntries => 'You can add up to 2 entries in the free version.';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get addFirstSecureEntry => 'Tap the + button to add your first secure entry.';

  @override
  String get addIban => 'Add IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Authenticate to continue';

  @override
  String get bankDetails => 'Bank Details';

  @override
  String get biometric => 'Biometric';

  @override
  String get biometricFailed => 'Biometric failed';

  @override
  String get biometricNotAvailable => 'Biometric not available';

  @override
  String get biometricSuccess => 'Biometric success';

  @override
  String get biometricWithBackupPin => 'Biometric - with PIN backup';

  @override
  String get collection => 'Collection';

  @override
  String get collectionExample => 'e.g. Backups';

  @override
  String get confirmPattern => 'Draw the same pattern again to confirm';

  @override
  String get confirmPin => 'Confirm PIN';

  @override
  String get continueText => 'Continue';

  @override
  String get created => 'Created';

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
  String get details => 'Details';

  @override
  String get drawNewPattern => 'Draw a new pattern';

  @override
  String get drawVaultKey => 'Draw your vault key';

  @override
  String get editEntry => 'Edit Entry';

  @override
  String get enableVaultWord => 'Enable Vault Word';

  @override
  String get enterPin => 'Enter PIN';

  @override
  String get enterPinHint => 'Enter 5-digit PIN';

  @override
  String get enterVaultWord => 'Enter your vault word';

  @override
  String get entryDetails => 'Entry Details';

  @override
  String get export => 'Export';

  @override
  String get exportComingNext => 'Export coming next';

  @override
  String get exportCompleted => 'Export completed';

  @override
  String get exportData => 'Export Data';

  @override
  String get exportPin => 'Backup PIN';

  @override
  String get generatePassword => 'Generate Password';

  @override
  String get generatePasswordDescription => 'Create a strong password below. Copying it will also fill the password field.';

  @override
  String get generate => 'Generate';

  @override
  String get hideSensitiveContent => 'Hide sensitive content until unlocked';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN copied';

  @override
  String get import => 'Import';

  @override
  String get importCompleted => 'Import completed';

  @override
  String get importData => 'Import Data';

  @override
  String get importFailed => 'Import failed';

  @override
  String get importPin => 'Restore Pin';

  @override
  String get language => 'Language';

  @override
  String get lynraSecurity => 'Lynra Security';

  @override
  String get max5Collections => 'Maximum 5 collections allowed';

  @override
  String get medium => 'Medium';

  @override
  String get min5Dots => 'Use at least 5 dots';

  @override
  String get modified => 'Modified';

  @override
  String get myVault => 'My Vault';

  @override
  String get newCollection => 'New Collection';

  @override
  String get newEntry => 'New Entry';

  @override
  String get noEntriesYet => 'No entries yet';

  @override
  String get none => 'None';

  @override
  String get noNoteAdded => 'No note added';

  @override
  String get noPasswordGenerated => 'No password generated yet';

  @override
  String get note => 'Note';

  @override
  String get noteType => 'Note';

  @override
  String get noUsername => 'No username';

  @override
  String get onboardingDescription => 'Your data stays on your device.\n\nLynraGreyNote does not use servers, does not track you, and does not collect any information.\n\nEverything you save is encrypted and stored locally.\nYou are the only one who can access it.\n\nUse Secondary PIN or Biometrics for quick and secure access.\nEnable Vault Word to add an extra layer of privacy and hide your content when needed.';

  @override
  String get optionalNote => 'Optional note';

  @override
  String get password => 'Password';

  @override
  String get passwordCopied => 'Password copied';

  @override
  String get patternMismatch => 'Patterns did not match. Start again';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN must be 6 digits';

  @override
  String get pinSaved => 'PIN saved';

  @override
  String get pinsDoNotMatch => 'PINs do not match';

  @override
  String get privateByDesign => 'Privacy is a fundamental, not a feature';

  @override
  String get save => 'Save';

  @override
  String get savePin => 'Save PIN';

  @override
  String get secondaryLock => 'Secondary Lock';

  @override
  String get security => 'Security';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get settings => 'Settings';

  @override
  String get setPin => 'Set PIN';

  @override
  String get standard => 'Standard';

  @override
  String get strong => 'Strong';

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
  String get weak => 'Weak';

  @override
  String get wrongPattern => 'Wrong pattern. Try again';

  @override
  String get wrongPin => 'Wrong PIN';

  @override
  String get title => 'Title';

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

  @override
  String get username => 'Username';

  @override
  String get usernameCopied => 'Username copied';

  @override
  String get usernameEmail => 'Username / Email';
}
