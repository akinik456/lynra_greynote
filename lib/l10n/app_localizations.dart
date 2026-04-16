import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @confirmPattern.
  ///
  /// In en, this message translates to:
  /// **'Draw the same pattern again to confirm'**
  String get confirmPattern;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @createVaultKey.
  ///
  /// In en, this message translates to:
  /// **'Create Your Vault Key'**
  String get createVaultKey;

  /// No description provided for @drawNewPattern.
  ///
  /// In en, this message translates to:
  /// **'Draw a new pattern'**
  String get drawNewPattern;

  /// No description provided for @drawVaultKey.
  ///
  /// In en, this message translates to:
  /// **'Draw your vault key'**
  String get drawVaultKey;

  /// No description provided for @lynraSecurity.
  ///
  /// In en, this message translates to:
  /// **'Lynra Security'**
  String get lynraSecurity;

  /// No description provided for @min4Dots.
  ///
  /// In en, this message translates to:
  /// **'Use at least 4 dots'**
  String get min4Dots;

  /// No description provided for @onboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Your data stays on your device.\n\nLynraGreyNote does not use servers, does not track you, and does not collect any information.\n\nEverything you save is encrypted and stored locally.\nYou are the only one who can access it.\n\nUse Secondary PIN or Biometrics for quick and secure access.\nEnable Vault Word to add an extra layer of privacy and hide your content when needed.'**
  String get onboardingDescription;

  /// No description provided for @patternMismatch.
  ///
  /// In en, this message translates to:
  /// **'Patterns did not match. Start again'**
  String get patternMismatch;

  /// No description provided for @privateByDesign.
  ///
  /// In en, this message translates to:
  /// **'Private by Design'**
  String get privateByDesign;

  /// No description provided for @wrongPattern.
  ///
  /// In en, this message translates to:
  /// **'Wrong pattern. Try again'**
  String get wrongPattern;

  /// No description provided for @unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// No description provided for @unlockVault.
  ///
  /// In en, this message translates to:
  /// **'Unlock Vault'**
  String get unlockVault;

  /// No description provided for @deleteEntry.
  ///
  /// In en, this message translates to:
  /// **'Delete entry'**
  String get deleteEntry;

  /// No description provided for @deleteEntryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"?'**
  String deleteEntryConfirm(Object name);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @unlockContent.
  ///
  /// In en, this message translates to:
  /// **'Unlock Content'**
  String get unlockContent;

  /// No description provided for @max5Collections.
  ///
  /// In en, this message translates to:
  /// **'Maximum 5 collections allowed'**
  String get max5Collections;

  /// No description provided for @newCollection.
  ///
  /// In en, this message translates to:
  /// **'New Collection'**
  String get newCollection;

  /// No description provided for @collectionExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Mom'**
  String get collectionExample;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @deleteCollection.
  ///
  /// In en, this message translates to:
  /// **'Delete Collection'**
  String get deleteCollection;

  /// No description provided for @deleteCollectionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"?\n\nAll entries will be permanently deleted.'**
  String deleteCollectionConfirm(Object name);

  /// No description provided for @myVault.
  ///
  /// In en, this message translates to:
  /// **'My Vault'**
  String get myVault;

  /// No description provided for @vaultHeaderStats.
  ///
  /// In en, this message translates to:
  /// **'{collection} • {count} {count,plural, =1{item} other{items}}'**
  String vaultHeaderStats(Object collection, int count);

  /// No description provided for @untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitled;

  /// No description provided for @noUsername.
  ///
  /// In en, this message translates to:
  /// **'No username'**
  String get noUsername;

  /// No description provided for @updatedDate.
  ///
  /// In en, this message translates to:
  /// **'Updated {date}'**
  String updatedDate(Object date);

  /// No description provided for @noEntriesYet.
  ///
  /// In en, this message translates to:
  /// **'No entries yet'**
  String get noEntriesYet;

  /// No description provided for @addFirstSecureEntry.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to add your first secure entry.'**
  String get addFirstSecureEntry;

  /// No description provided for @collection.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collection;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'LynraGreyNote'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @vaultWord.
  ///
  /// In en, this message translates to:
  /// **'Vault Word'**
  String get vaultWord;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @editEntry.
  ///
  /// In en, this message translates to:
  /// **'Edit Entry'**
  String get editEntry;

  /// No description provided for @newEntry.
  ///
  /// In en, this message translates to:
  /// **'New Entry'**
  String get newEntry;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
