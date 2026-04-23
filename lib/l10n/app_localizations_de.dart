// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get search => 'Suchen';

  @override
  String get unlockToSearch => 'Zum Suchen entsperren';

  @override
  String get limitReached => 'Limit erreicht';

  @override
  String get freeLimitEntries => 'In der kostenlosen Version kannst du bis zu 2 Einträge hinzufügen.';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get addFirstSecureEntry => 'Tippen Sie auf die + Taste, um Ihren ersten sicheren Eintrag hinzuzufügen.';

  @override
  String get addIban => 'IBAN hinzufügen';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Zur Fortsetzung authentifizieren';

  @override
  String get bankDetails => 'Bankdaten';

  @override
  String get biometric => 'Biometrie';

  @override
  String get biometricFailed => 'Biometrie fehlgeschlagen';

  @override
  String get biometricNotAvailable => 'Biometrie nicht verfügbar';

  @override
  String get biometricSuccess => 'Biometrie erfolgreich';

  @override
  String get biometricWithBackupPin => 'Biometrisch - mit PIN-Backup';

  @override
  String get collection => 'Sammlung';

  @override
  String get collectionExample => 'z. B. Sicherungen';

  @override
  String get confirmPattern => 'Muster zur Bestätigung erneut zeichnen';

  @override
  String get confirmPin => 'PIN bestätigen';

  @override
  String get continueText => 'Weiter';

  @override
  String get created => 'Erstellt';

  @override
  String get createVaultKey => 'Tresorschlüssel erstellen';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteCollection => 'Sammlung löschen';

  @override
  String deleteCollectionConfirm(Object name) {
    return '\"$name\" löschen?\n\nAlle Einträge werden dauerhaft entfernt.';
  }

  @override
  String get deleteEntry => 'Eintrag löschen';

  @override
  String deleteEntryConfirm(Object name) {
    return '\"$name\" löschen?';
  }

  @override
  String get details => 'Details';

  @override
  String get drawNewPattern => 'Neues Muster zeichnen';

  @override
  String get drawVaultKey => 'Tresorschlüssel zeichnen';

  @override
  String get editEntry => 'Eintrag bearbeiten';

  @override
  String get enableVaultWord => 'Tresorwort aktivieren';

  @override
  String get enterPin => 'PIN eingeben';

  @override
  String get enterPinHint => '5-stellige PIN eingeben';

  @override
  String get enterVaultWord => 'Tresorwort eingeben';

  @override
  String get entryDetails => 'Eintragsdetails';

  @override
  String get export => 'Exportieren';

  @override
  String get exportComingNext => 'Export folgt bald';

  @override
  String get exportCompleted => 'Export abgeschlossen';

  @override
  String get exportData => 'Daten exportieren';

  @override
  String get exportPin => 'Backup-PIN';

  @override
  String get generatePassword => 'Passwort generieren';

  @override
  String get generatePasswordDescription => 'Erstellen Sie unten ein sicheres Passwort. Beim Kopieren wird es auch in das Passwortfeld eingefügt.';

  @override
  String get generate => 'Generieren';

  @override
  String get hideSensitiveContent => 'Sensible Inhalte bis zur Entsperrung ausblenden';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN kopiert';

  @override
  String get import => 'Importieren';

  @override
  String get importCompleted => 'Import abgeschlossen';

  @override
  String get importData => 'Daten importieren';

  @override
  String get importFailed => 'Import fehlgeschlagen';

  @override
  String get importPin => 'Wiederherstellungs-PIN';

  @override
  String get language => 'Sprache';

  @override
  String get lynraSecurity => 'Lynra Sicherheit';

  @override
  String get max5Collections => 'Maximal 5 Sammlungen erlaubt';

  @override
  String get medium => 'Mittel';

  @override
  String get min5Dots => 'Mindestens 5 Punkte verwenden';

  @override
  String get modified => 'Geändert';

  @override
  String get myVault => 'Mein Tresor';

  @override
  String get newCollection => 'Neue Sammlung';

  @override
  String get newEntry => 'Neuer Eintrag';

  @override
  String get noEntriesYet => 'Noch keine Einträge';

  @override
  String get none => 'Keine';

  @override
  String get noNoteAdded => 'Keine Notiz hinzugefügt';

  @override
  String get noPasswordGenerated => 'Noch kein Passwort generiert';

  @override
  String get note => 'Notiz';

  @override
  String get noteType => 'Notiz';

  @override
  String get noUsername => 'Kein Benutzername';

  @override
  String get onboardingDescription => 'Deine Daten bleiben auf deinem Gerät.\n\nLynraGreyNote nutzt keine Server, verfolgt dich nicht und sammelt keine Daten.\n\nAlles wird verschlüsselt und lokal gespeichert.\nNur Sie haben Zugriff darauf.Nur Sie haben Zugriff darauf.\n\nNutze sekundäre PIN oder Biometrie für schnellen und sicheren Zugriff.\nAktiviere das Tresorwort für zusätzliche Privatsphäre und zum Verbergen deiner Inhalte.';

  @override
  String get optionalNote => 'Optionale Notiz';

  @override
  String get password => 'Passwort';

  @override
  String get passwordCopied => 'Passwort kopiert';

  @override
  String get patternMismatch => 'Muster stimmen nicht überein. Erneut versuchen';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN muss 6-stellig sein';

  @override
  String get pinSaved => 'PIN gespeichert';

  @override
  String get pinsDoNotMatch => 'PINs stimmen nicht überein';

  @override
  String get privateByDesign => 'Privatsphäre ist grundlegend, kein Feature';

  @override
  String get save => 'Speichern';

  @override
  String get savePin => 'PIN speichern';

  @override
  String get secondaryLock => 'Sekundäre Sperre';

  @override
  String get security => 'Sicherheit';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get setPin => 'PIN festlegen';

  @override
  String get standard => 'Standard';

  @override
  String get strong => 'Stark';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Einträge',
      one: 'Eintrag',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'Tresorwort';

  @override
  String get weak => 'Schwach';

  @override
  String get wrongPattern => 'Falsches Muster. Erneut versuchen';

  @override
  String get wrongPin => 'Falsche PIN';

  @override
  String get title => 'Titel';

  @override
  String get unlock => 'Entsperren';

  @override
  String get unlockContent => 'Inhalt entsperren';

  @override
  String get unlockVault => 'Tresor entsperren';

  @override
  String get untitled => 'Ohne Titel';

  @override
  String updatedDate(Object date) {
    return 'Aktualisiert am $date';
  }

  @override
  String get username => 'Benutzername';

  @override
  String get usernameCopied => 'Benutzername kopiert';

  @override
  String get usernameEmail => 'Benutzername / E-Mail';
}
