// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get add => 'Toevoegen';

  @override
  String get addFirstSecureEntry => 'Tik op de + knop om je eerste veilige item toe te voegen.';

  @override
  String get addIban => 'IBAN toevoegen';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Verifieer om door te gaan';

  @override
  String get bankDetails => 'Bankgegevens';

  @override
  String get biometric => 'Biometrie';

  @override
  String get biometricFailed => 'Biometrie mislukt';

  @override
  String get biometricNotAvailable => 'Biometrie niet beschikbaar';

  @override
  String get biometricSuccess => 'Biometrie geslaagd';

  @override
  String get biometricWithBackupPin => 'Biometric with PIN backup';

  @override
  String get biometricWithBackupPinDescription => 'Use biometric for quick access, PIN if needed.';

  @override
  String get cancel => 'Annuleren';

  @override
  String get collection => 'Collectie';

  @override
  String get collectionExample => 'bijv. Back-ups';

  @override
  String get confirmPattern => 'Teken hetzelfde patroon opnieuw om te bevestigen';

  @override
  String get confirmPin => 'Bevestig PIN';

  @override
  String get continueText => 'Doorgaan';

  @override
  String get created => 'Aangemaakt';

  @override
  String get createVaultKey => 'Maak je kluissleutel';

  @override
  String get delete => 'Verwijderen';

  @override
  String get deleteCollection => 'Collectie verwijderen';

  @override
  String deleteCollectionConfirm(Object name) {
    return '\"$name\" verwijderen?\n\nAlle items worden permanent verwijderd.';
  }

  @override
  String get deleteEntry => 'Item verwijderen';

  @override
  String deleteEntryConfirm(Object name) {
    return '\"$name\" verwijderen?';
  }

  @override
  String get details => 'Details';

  @override
  String get drawNewPattern => 'Teken een nieuw patroon';

  @override
  String get drawVaultKey => 'Teken je kluissleutel';

  @override
  String get editEntry => 'Item bewerken';

  @override
  String get enableVaultWord => 'Kluissleutelwoord inschakelen';

  @override
  String get enterPin => 'Voer PIN in';

  @override
  String get enterPinHint => 'Voer 5-cijferige PIN in';

  @override
  String get enterVaultWord => 'Voer je kluissleutelwoord in';

  @override
  String get entryDetails => 'Itemdetails';

  @override
  String get export => 'Exporteren';

  @override
  String get exportComingNext => 'Export komt binnenkort';

  @override
  String get exportCompleted => 'Export voltooid';

  @override
  String get exportData => 'Gegevens exporteren';

  @override
  String get exportPin => 'Back-up PIN';

  @override
  String get generatePassword => 'Wachtwoord genereren';

  @override
  String get generatePasswordDescription => 'Maak hieronder een sterk wachtwoord. Kopiëren vult ook het veld in.';

  @override
  String get generate => 'Genereren';

  @override
  String get hideSensitiveContent => 'Verberg gevoelige inhoud tot ontgrendeld';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN gekopieerd';

  @override
  String get import => 'Importeren';

  @override
  String get importCompleted => 'Import voltooid';

  @override
  String get importData => 'Gegevens importeren';

  @override
  String get importFailed => 'Import mislukt';

  @override
  String get importPin => 'Herstel-PIN';

  @override
  String get language => 'Taal';

  @override
  String get lynraSecurity => 'Lynra Beveiliging';

  @override
  String get max5Collections => 'Maximaal 5 collecties toegestaan';

  @override
  String get medium => 'Gemiddeld';

  @override
  String get min5Dots => 'Gebruik minimaal 5 punten';

  @override
  String get modified => 'Aangepast';

  @override
  String get myVault => 'Mijn kluis';

  @override
  String get newCollection => 'Nieuwe collectie';

  @override
  String get newEntry => 'Nieuw item';

  @override
  String get noEntriesYet => 'Nog geen items';

  @override
  String get none => 'Geen';

  @override
  String get noNoteAdded => 'Geen notitie toegevoegd';

  @override
  String get noPasswordGenerated => 'Nog geen wachtwoord gegenereerd';

  @override
  String get note => 'Notitie';

  @override
  String get noteType => 'Notitie';

  @override
  String get noUsername => 'Geen gebruikersnaam';

  @override
  String get onboardingDescription => 'Je gegevens blijven op je apparaat.\n\nLynraGreyNote gebruikt geen servers, volgt je niet en verzamelt geen informatie.\n\nAlles wat je opslaat wordt versleuteld en lokaal bewaard.\nAlleen jij hebt toegang.\n\nGebruik een secundaire PIN of biometrie voor snelle en veilige toegang.\nSchakel het kluissleutelwoord in voor extra privacy en om inhoud te verbergen wanneer nodig.';

  @override
  String get optionalNote => 'Optionele notitie';

  @override
  String get password => 'Wachtwoord';

  @override
  String get passwordCopied => 'Wachtwoord gekopieerd';

  @override
  String get patternMismatch => 'Patronen komen niet overeen. Probeer opnieuw';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN moet 6 cijfers zijn';

  @override
  String get pinSaved => 'PIN opgeslagen';

  @override
  String get pinsDoNotMatch => 'PIN\'s komen niet overeen';

  @override
  String get privateByDesign => 'Privacy is een basis, geen functie';

  @override
  String get save => 'Opslaan';

  @override
  String get savePin => 'PIN opslaan';

  @override
  String get secondaryLock => 'Secundaire vergrendeling';

  @override
  String get security => 'Beveiliging';

  @override
  String get selectLanguage => 'Selecteer taal';

  @override
  String get settings => 'Instellingen';

  @override
  String get setPin => 'PIN instellen';

  @override
  String get standard => 'Standaard';

  @override
  String get strong => 'Sterk';

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
  String get vaultWord => 'Kluissleutelwoord';

  @override
  String get weak => 'Zwak';

  @override
  String get wrongPattern => 'Onjuist patroon. Probeer opnieuw';

  @override
  String get wrongPin => 'Onjuiste PIN';

  @override
  String get title => 'Titel';

  @override
  String get unlock => 'Ontgrendelen';

  @override
  String get unlockContent => 'Inhoud ontgrendelen';

  @override
  String get unlockVault => 'Kluis ontgrendelen';

  @override
  String get untitled => 'Zonder titel';

  @override
  String updatedDate(Object date) {
    return 'Bijgewerkt $date';
  }

  @override
  String get username => 'Gebruikersnaam';

  @override
  String get usernameCopied => 'Gebruikersnaam gekopieerd';

  @override
  String get usernameEmail => 'Gebruikersnaam / E-mail';
}
