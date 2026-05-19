// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get shareText => 'Lynra GreyNote - Offline en Privékluis. Geen cloud. Geen advertenties. Geen abonnement.';

  @override
  String get add => 'Toevoegen';

  @override
  String get addAttachment => 'Bestand toevoegen';

  @override
  String get addFirstSecureEntry => 'Tik op de + knop om je eerste veilige item toe te voegen.';

  @override
  String get addIban => 'IBAN toevoegen';

  @override
  String get advancedSecurityBody => 'Lynra GreyNote is ontworpen volgens moderne cryptografische principes.\n\nGegevensbescherming:\nDe inhoud van items wordt versleuteld met het AES-256-GCM-algoritme.\nDe database wordt volledig versleuteld opgeslagen met SQLCipher.\n\nSleutelbeheer:\nDe hoofdsleutel (Master Key) wordt afgeleid van gebruikerssleutels met het PBKDF2-HMAC-SHA256-algoritme.\nDeze sleutel wordt nooit in platte tekst opgeslagen en alleen gebruikt tijdens de actieve sessie.\n\nSleutelscheiding (Key Separation):\nDatabase-toegang en gegevensversleuteling gebruiken verschillende sleutels.\n\nExtra beveiligingslaag:\nWanneer Vault Word is ingeschakeld, worden de gegevens beschermd door een tweede laag.\nDeze sleutel wordt niet op het apparaat opgeslagen en is alleen bekend bij de gebruiker.\n\nSessiebeveiliging:\nWanneer de app naar de achtergrond gaat, wordt de toegang automatisch vergrendeld.\nEncryptiesleutels worden alleen tijdens verwerking in het geheugen gehouden.\n\nSchermbeveiliging:\nScreenshots en schermopnames worden op systeemniveau geblokkeerd.\n\nBack-up:\nBij export worden gegevens aangemaakt als een versleuteld blok (encrypted blob) en kunnen alleen met de juiste informatie worden hersteld.\n\nLynra heeft geen toegang tot gebruikersgegevens en kan deze niet lezen of herstellen.\n\nHet volledige beveiligingsmodel is gebaseerd op volledige controle van de gebruiker over de gegevens.';

  @override
  String get advancedSecurityTitle => 'Geavanceerde beveiliging';

  @override
  String get alreadyExists => 'Dit item bestaat al';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get attachmentReady => 'Bijlage klaar';

  @override
  String get attachmentRemoved => 'Bijlage verwijderd';

  @override
  String get attachmentTooLarge => 'Maximaal 5 MB';

  @override
  String get authenticateToContinue => 'Verifieer om door te gaan';

  @override
  String get backupReminder => 'Overweeg een back-up te maken om je gegevens te beschermen';

  @override
  String get backupPatternWarning => 'Hetzelfde patroonslot is vereist om deze back-up te importeren.';

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
  String get biometricWithBackupPin => 'Biometrisch - met PIN-back-up';

  @override
  String get cancel => 'Annuleren';

  @override
  String get clear => 'Wissen';

  @override
  String get clearMyVault => 'Mijn Vault Wissen';

  @override
  String get clearMyVaultConfirm => 'Hiermee worden alle items in Mijn Vault verwijderd. Dit kan niet ongedaan worden gemaakt.';

  @override
  String get close => 'Sluiten';

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
  String get csvimportfailed => 'CSV-import mislukt.';

  @override
  String get csvTemplate => 'CSV-sjabloon';

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
  String get disable => 'Uitschakelen';

  @override
  String get disableVaultWord => 'Vault-woord uitschakelen';

  @override
  String get downloadTemplate => 'Sjabloon downloaden';

  @override
  String get drawNewPattern => 'Teken een nieuw patroon';

  @override
  String get drawVaultKey => 'Teken je kluissleutel';

  @override
  String get duplicate => 'Duplicaat';

  @override
  String get editEntry => 'Item bewerken';

  @override
  String get earlysupporter => 'Launchondersteuningsprogramma';

  @override
  String get earlysupporterText => 'Launch Special: Help ons Lynra GreyNote te verbeteren! 💙\nAls je de app nuttig vindt, kun je onze ontwikkeling steunen door een eerlijke recensie achter te laten in de Play Store.\nStuur ons na het beoordelen eenvoudig je Play Store-gebruikersnaam via Instellingen → Feedback per e-mail. Exclusief voor de eerste week schenken we een Levenslange Premium toegangscode aan onze vroege supporters! 🙂';

  @override
  String get empty => 'Leeg';

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
  String get exportBackup => 'Versleutelde back-up exporteren';

  @override
  String get exportComingNext => 'Export komt binnenkort';

  @override
  String get exportCompleted => 'Export voltooid';

  @override
  String get exportCSV => 'Exporteren als CSV-bestand';

  @override
  String get exportData => 'Gegevens exporteren';

  @override
  String get exportPin => 'Back-up PIN';

  @override
  String get exportText => 'Exporteren als tekstbestand';

  @override
  String get feedback => 'Feedback';

  @override
  String get freeLimitEntries => 'Je kunt maximaal 2 items toevoegen in de gratis versie.';

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
  String get imported => 'Geïmporteerd';

  @override
  String get importBackup => 'Versleutelde back-up importeren';

  @override
  String get importCompleted => 'Import voltooid';

  @override
  String get importCSV => 'Importeren vanuit CSV-bestand';

  @override
  String get importData => 'Gegevens importeren';

  @override
  String get importFailed => 'Import mislukt';

  @override
  String get importPin => 'Herstel-PIN';

  @override
  String get importText => 'Importeren vanuit tekstbestand';

  @override
  String get language => 'Taal';

  @override
  String get limitReached => 'Limiet bereikt';

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
  String get myVaultCleared => 'Vault gewist';

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
  String get pattern => 'Patroon';

  @override
  String get patternMismatch => 'Patronen komen niet overeen. Probeer opnieuw';

  @override
  String get patternSkipped => 'Patroon overgeslagen';

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
  String get rateOnPlayStore => 'Beoordeel';

  @override
  String get removeAttachment => 'Bestand verwijderen';

  @override
  String get save => 'Opslaan';

  @override
  String get savePin => 'PIN opslaan';

  @override
  String get search => 'Zoeken';

  @override
  String get secondaryLock => 'Secundaire vergrendeling';

  @override
  String get security => 'Beveiliging';

  @override
  String get securityManifesto => 'Beveiligingsmodel';

  @override
  String get securitySummaryBody => 'Lynra GreyNote is een offline veilige kluis die uw gegevens uitsluitend op uw apparaat opslaat.\nDe applicatie gebruikt geen servers, volgt u niet en verzamelt geen gegevens.\nAl uw items worden beschermd met sterke encryptie en zijn alleen voor u toegankelijk.\nWanneer de app naar de achtergrond gaat, wordt deze automatisch vergrendeld en worden screenshots geblokkeerd.\nAls de ontgrendelingsgegevens worden vergeten, kunnen de gegevens niet worden hersteld.\nVoor gedetailleerde technische informatie raadpleegt u de sectie Geavanceerde beveiliging hieronder.';

  @override
  String get securitySummaryTitle => 'Beveiligingsoverzicht';

  @override
  String get selectLanguage => 'Selecteer taal';

  @override
  String get settings => 'Instellingen';

  @override
  String get setPin => 'PIN instellen';

  @override
  String get share => 'Delen';

  @override
  String get sort => 'Sorteren';

  @override
  String get sortFavorites => 'Favorieten';

  @override
  String get sortUpdated => 'Laatst bijgewerkt';

  @override
  String get sortAZ => 'A–Z';

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
  String get viewAttachment => 'Bijlage bekijken';

  @override
  String get wrongPattern => 'Onjuist patroon. Probeer opnieuw';

  @override
  String get wrongPin => 'Onjuiste PIN';

  @override
  String get textTemplate => 'Tekstsjabloon';

  @override
  String get title => 'Titel';

  @override
  String get txtImportCompleted => 'Importeren voltooid.';

  @override
  String get txtImportCompletedWithSkip => 'Importeren voltooid. %d patroon-items zijn overgeslagen.';

  @override
  String get txtExportCompletedWithSkip => 'Exporteren voltooid. Dit bestand is niet versleuteld. %d patroon-items zijn overgeslagen.';

  @override
  String get txtExportCompleted => 'Export voltooid. Dit bestand is niet versleuteld.';

  @override
  String get unlock => 'Ontgrendelen';

  @override
  String get unlockContent => 'Inhoud ontgrendelen';

  @override
  String get unlockVault => 'Kluis ontgrendelen';

  @override
  String get unlockToSearch => 'Ontgrendel om te zoeken';

  @override
  String get upgrade => 'Upgraden';

  @override
  String get untitled => 'Zonder titel';

  @override
  String updatedDate(Object date) {
    return 'Bijgewerkt $date';
  }

  @override
  String get usageGuide => 'Gebruikershandleiding';

  @override
  String get usageGuideText => '• Je gegevens worden alleen op je apparaat opgeslagen.\n\n• Regelmatige back-ups worden aanbevolen om je gegevens te beschermen bij situaties zoals het wisselen van apparaat.\n\n• Patroonitems worden om veiligheidsredenen niet opgenomen in exportbestanden.\n\n• Vault Word verbergt gevoelige inhoud op het scherm.\n\n• De app wordt automatisch vergrendeld wanneer deze naar de achtergrond gaat.\n\n• Deze app gebruikt geen cloudsynchronisatie of externe servers.\n\n• Download voor importbewerkingen eerst het juiste sjabloonbestand en maak je gegevens volgens dat formaat aan.\n\n• Houd een item of collectie ingedrukt om deze te verwijderen.';

  @override
  String get username => 'Gebruikersnaam';

  @override
  String get usernameCopied => 'Gebruikersnaam gekopieerd';

  @override
  String get usernameEmail => 'Gebruikersnaam / E-mail';
}
