// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get attachmentRemoved => 'Attachment removed';

  @override
  String get viewAttachment => 'Visa bilaga';

  @override
  String get addAttachment => 'Lägg till bilaga';

  @override
  String get attachmentReady => 'Bilaga klar';

  @override
  String get attachmentTooLarge => 'Bilaga borttagen';

  @override
  String get search => 'Sök';

  @override
  String get unlockToSearch => 'Lås upp för att söka';

  @override
  String get limitReached => 'Gräns nådd';

  @override
  String get freeLimitEntries => 'Du kan lägga till upp till 2 poster i gratisversionen.';

  @override
  String get upgrade => 'Uppgradera';

  @override
  String get cancel => 'Avbryt';

  @override
  String get add => 'Lägg till';

  @override
  String get addFirstSecureEntry => 'Tryck på + för att lägga till din första säkra post.';

  @override
  String get addIban => 'Lägg till IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Autentisera för att fortsätta';

  @override
  String get bankDetails => 'Bankuppgifter';

  @override
  String get biometric => 'Biometri';

  @override
  String get biometricFailed => 'Biometri misslyckades';

  @override
  String get biometricNotAvailable => 'Biometri ej tillgänglig';

  @override
  String get biometricSuccess => 'Biometri lyckades';

  @override
  String get biometricWithBackupPin => 'Biometrisk - med PIN som backup';

  @override
  String get collection => 'Samling';

  @override
  String get collectionExample => 't.ex. Säkerhetskopior';

  @override
  String get confirmPattern => 'Rita samma mönster igen för att bekräfta';

  @override
  String get confirmPin => 'Bekräfta PIN';

  @override
  String get continueText => 'Fortsätt';

  @override
  String get created => 'Skapad';

  @override
  String get createVaultKey => 'Skapa din nyckel';

  @override
  String get delete => 'Ta bort';

  @override
  String get deleteCollection => 'Ta bort samling';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'Ta bort \"$name\"?\n\nAlla poster raderas permanent.';
  }

  @override
  String get deleteEntry => 'Ta bort post';

  @override
  String deleteEntryConfirm(Object name) {
    return 'Ta bort \"$name\"?';
  }

  @override
  String get details => 'Detaljer';

  @override
  String get drawNewPattern => 'Rita nytt mönster';

  @override
  String get drawVaultKey => 'Rita din nyckel';

  @override
  String get editEntry => 'Redigera post';

  @override
  String get enableVaultWord => 'Aktivera valvord';

  @override
  String get enterPin => 'Ange PIN';

  @override
  String get enterPinHint => 'Ange 5-siffrig PIN';

  @override
  String get enterVaultWord => 'Ange ditt valvord';

  @override
  String get entryDetails => 'Postdetaljer';

  @override
  String get export => 'Exportera';

  @override
  String get exportComingNext => 'Export kommer snart';

  @override
  String get exportCompleted => 'Export klar';

  @override
  String get exportData => 'Exportera data';

  @override
  String get exportPin => 'Säkerhetskopierings-PIN';

  @override
  String get generatePassword => 'Generera lösenord';

  @override
  String get generatePasswordDescription => 'Skapa ett starkt lösenord nedan. Kopiering fyller även i fältet.';

  @override
  String get generate => 'Generera';

  @override
  String get hideSensitiveContent => 'Dölj känsligt innehåll tills det låses upp';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN kopierat';

  @override
  String get import => 'Importera';

  @override
  String get importCompleted => 'Import klar';

  @override
  String get importData => 'Importera data';

  @override
  String get importFailed => 'Import misslyckades';

  @override
  String get importPin => 'Återställnings-PIN';

  @override
  String get language => 'Språk';

  @override
  String get lynraSecurity => 'Lynra Säkerhet';

  @override
  String get max5Collections => 'Max 5 samlingar';

  @override
  String get medium => 'Medel';

  @override
  String get min5Dots => 'Använd minst 5 punkter';

  @override
  String get modified => 'Ändrad';

  @override
  String get myVault => 'Mitt valv';

  @override
  String get newCollection => 'Ny samling';

  @override
  String get newEntry => 'Ny post';

  @override
  String get noEntriesYet => 'Inga poster än';

  @override
  String get none => 'Ingen';

  @override
  String get noNoteAdded => 'Ingen anteckning';

  @override
  String get noPasswordGenerated => 'Inget lösenord än';

  @override
  String get note => 'Anteckning';

  @override
  String get noteType => 'Anteckning';

  @override
  String get noUsername => 'Inget användarnamn';

  @override
  String get onboardingDescription => 'Dina data stannar på din enhet.\n\nLynraGreyNote använder inga servrar, spårar dig inte och samlar inte in någon information.\n\nAllt sparas krypterat lokalt.\nEndast du har åtkomst.\n\nAnvänd sekundär PIN eller biometri för snabb och säker åtkomst.\nAktivera valvord för extra integritet och för att dölja innehåll vid behov.';

  @override
  String get optionalNote => 'Valfri anteckning';

  @override
  String get password => 'Lösenord';

  @override
  String get passwordCopied => 'Lösenord kopierat';

  @override
  String get patternMismatch => 'Mönster matchade inte. Försök igen';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN måste vara 6 siffror';

  @override
  String get pinSaved => 'PIN sparad';

  @override
  String get pinsDoNotMatch => 'PIN matchar inte';

  @override
  String get privateByDesign => 'Integritet är grund, inte funktion';

  @override
  String get save => 'Spara';

  @override
  String get savePin => 'Spara PIN';

  @override
  String get secondaryLock => 'Sekundärt lås';

  @override
  String get security => 'Säkerhet';

  @override
  String get selectLanguage => 'Välj språk';

  @override
  String get settings => 'Inställningar';

  @override
  String get setPin => 'Ställ in PIN';

  @override
  String get standard => 'Standard';

  @override
  String get strong => 'Stark';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'objekt',
      one: 'objekt',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'Valvord';

  @override
  String get weak => 'Svag';

  @override
  String get wrongPattern => 'Fel mönster. Försök igen';

  @override
  String get wrongPin => 'Fel PIN';

  @override
  String get title => 'Titel';

  @override
  String get unlock => 'Lås upp';

  @override
  String get unlockContent => 'Lås upp innehåll';

  @override
  String get unlockVault => 'Lås upp valv';

  @override
  String get untitled => 'Utan titel';

  @override
  String updatedDate(Object date) {
    return 'Uppdaterad $date';
  }

  @override
  String get username => 'Användarnamn';

  @override
  String get usernameCopied => 'Användarnamn kopierat';

  @override
  String get usernameEmail => 'Användarnamn / E-post';
}
