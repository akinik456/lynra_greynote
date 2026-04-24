// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get removeAttachment => 'Rimuovi file';

  @override
  String get attachmentRemoved => 'Allegato rimosso';

  @override
  String get viewAttachment => 'Visualizza allegato';

  @override
  String get addAttachment => 'Aggiungi allegato';

  @override
  String get attachmentReady => 'Allegato pronto';

  @override
  String get attachmentTooLarge => 'Massimo 2 M';

  @override
  String get search => 'Cerca';

  @override
  String get unlockToSearch => 'Sblocca per cercare';

  @override
  String get limitReached => 'Limite raggiunto';

  @override
  String get freeLimitEntries => 'Puoi aggiungere fino a 2 elementi nella versione gratuita.';

  @override
  String get upgrade => 'Aggiorna';

  @override
  String get cancel => 'Annulla';

  @override
  String get add => 'Aggiungi';

  @override
  String get addFirstSecureEntry => 'Tocca il pulsante + per aggiungere il tuo primo elemento sicuro.';

  @override
  String get addIban => 'Aggiungi IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Autenticati per continuare';

  @override
  String get bankDetails => 'Dettagli bancari';

  @override
  String get biometric => 'Biometria';

  @override
  String get biometricFailed => 'Biometria fallita';

  @override
  String get biometricNotAvailable => 'Biometria non disponibile';

  @override
  String get biometricSuccess => 'Biometria riuscita';

  @override
  String get biometricWithBackupPin => 'Biometrico - con PIN di backup';

  @override
  String get collection => 'Collezione';

  @override
  String get collectionExample => 'es. Backup';

  @override
  String get confirmPattern => 'Disegna di nuovo lo stesso schema per confermare';

  @override
  String get confirmPin => 'Conferma PIN';

  @override
  String get continueText => 'Continua';

  @override
  String get created => 'Creato';

  @override
  String get createVaultKey => 'Crea il tuo schema di sicurezza';

  @override
  String get delete => 'Elimina';

  @override
  String get deleteCollection => 'Elimina collezione';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'Eliminare \"$name\"?\n\nTutti gli elementi saranno eliminati definitivamente.';
  }

  @override
  String get deleteEntry => 'Elimina elemento';

  @override
  String deleteEntryConfirm(Object name) {
    return 'Eliminare \"$name\"?';
  }

  @override
  String get details => 'Dettagli';

  @override
  String get drawNewPattern => 'Disegna un nuovo schema';

  @override
  String get drawVaultKey => 'Disegna il tuo schema di sicurezza';

  @override
  String get editEntry => 'Modifica elemento';

  @override
  String get enableVaultWord => 'Attiva la parola di sicurezza';

  @override
  String get enterPin => 'Inserisci PIN';

  @override
  String get enterPinHint => 'Inserisci PIN a 5 cifre';

  @override
  String get enterVaultWord => 'Inserisci la parola di sicurezza';

  @override
  String get entryDetails => 'Dettagli elemento';

  @override
  String get export => 'Esporta';

  @override
  String get exportComingNext => 'Esportazione in arrivo';

  @override
  String get exportCompleted => 'Esportazione completata';

  @override
  String get exportData => 'Esporta dati';

  @override
  String get exportPin => 'PIN di backup';

  @override
  String get generatePassword => 'Genera password';

  @override
  String get generatePasswordDescription => 'Crea una password sicura qui sotto. Copiandola verrà inserita anche nel campo password.';

  @override
  String get generate => 'Genera';

  @override
  String get hideSensitiveContent => 'Nascondi i contenuti sensibili fino allo sblocco';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN copiato';

  @override
  String get import => 'Importa';

  @override
  String get importCompleted => 'Importazione completata';

  @override
  String get importData => 'Importa dati';

  @override
  String get importFailed => 'Importazione fallita';

  @override
  String get importPin => 'PIN di ripristino';

  @override
  String get language => 'Lingua';

  @override
  String get lynraSecurity => 'Sicurezza Lynra';

  @override
  String get max5Collections => 'Massimo 5 collezioni consentite';

  @override
  String get medium => 'Media';

  @override
  String get min5Dots => 'Usa almeno 5 punti';

  @override
  String get modified => 'Modificato';

  @override
  String get myVault => 'Il mio archivio';

  @override
  String get newCollection => 'Nuova collezione';

  @override
  String get newEntry => 'Nuovo elemento';

  @override
  String get noEntriesYet => 'Nessun elemento per ora';

  @override
  String get none => 'Nessuno';

  @override
  String get noNoteAdded => 'Nessuna nota aggiunta';

  @override
  String get noPasswordGenerated => 'Nessuna password generata';

  @override
  String get note => 'Nota';

  @override
  String get noteType => 'Nota';

  @override
  String get noUsername => 'Nessun username';

  @override
  String get onboardingDescription => 'I tuoi dati restano sul tuo dispositivo.\n\nLynraGreyNote non utilizza server, non ti traccia e non raccoglie informazioni.\n\nTutto ciò che salvi è crittografato e memorizzato localmente.\nSolo tu puoi accedervi.\n\nUsa PIN secondario o biometria per un accesso rapido e sicuro.\nAttiva la parola vault per aggiungere un ulteriore livello di privacy e nascondere i contenuti quando necessario.';

  @override
  String get optionalNote => 'Nota opzionale';

  @override
  String get password => 'Password';

  @override
  String get passwordCopied => 'Password copiata';

  @override
  String get patternMismatch => 'Gli schemi non corrispondono. Riprova';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'Il PIN deve avere 6 cifre';

  @override
  String get pinSaved => 'PIN salvato';

  @override
  String get pinsDoNotMatch => 'I PIN non corrispondono';

  @override
  String get privateByDesign => 'La privacy è fondamentale, non una funzione';

  @override
  String get save => 'Salva';

  @override
  String get savePin => 'Salva PIN';

  @override
  String get secondaryLock => 'Blocco secondario';

  @override
  String get security => 'Sicurezza';

  @override
  String get selectLanguage => 'Seleziona lingua';

  @override
  String get settings => 'Impostazioni';

  @override
  String get setPin => 'Imposta PIN';

  @override
  String get standard => 'Standard';

  @override
  String get strong => 'Forte';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'elementi',
      one: 'elemento',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'Parola di sicurezza';

  @override
  String get weak => 'Debole';

  @override
  String get wrongPattern => 'Schema errato. Riprova';

  @override
  String get wrongPin => 'PIN errato';

  @override
  String get title => 'Titolo';

  @override
  String get unlock => 'Sblocca';

  @override
  String get unlockContent => 'Sblocca contenuto';

  @override
  String get unlockVault => 'Sblocca archivio';

  @override
  String get untitled => 'Senza titolo';

  @override
  String updatedDate(Object date) {
    return 'Aggiornato $date';
  }

  @override
  String get username => 'Nome utente';

  @override
  String get usernameCopied => 'Nome utente copiato';

  @override
  String get usernameEmail => 'Nome utente / Email';
}
