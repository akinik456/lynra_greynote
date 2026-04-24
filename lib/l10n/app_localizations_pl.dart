// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get removeAttachment => 'Usuń plik';

  @override
  String get attachmentRemoved => 'Załącznik usunięty';

  @override
  String get viewAttachment => 'Wyświetl załącznik';

  @override
  String get addAttachment => 'Dodaj plik';

  @override
  String get attachmentReady => 'Załącznik gotowy';

  @override
  String get attachmentTooLarge => 'Maksymalnie 2 MB';

  @override
  String get search => 'Szukaj';

  @override
  String get unlockToSearch => 'Odblokuj, aby wyszukać';

  @override
  String get limitReached => 'Osiągnięto limit';

  @override
  String get freeLimitEntries => 'W wersji darmowej możesz dodać maksymalnie 2 wpisy.';

  @override
  String get upgrade => 'Ulepsz';

  @override
  String get cancel => 'Anuluj';

  @override
  String get add => 'Dodaj';

  @override
  String get addFirstSecureEntry => 'Stuknij +, aby dodać pierwszy bezpieczny wpis.';

  @override
  String get addIban => 'Dodaj IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Uwierzytelnij, aby kontynuować';

  @override
  String get bankDetails => 'Dane bankowe';

  @override
  String get biometric => 'Biometria';

  @override
  String get biometricFailed => 'Błąd biometrii';

  @override
  String get biometricNotAvailable => 'Biometria niedostępna';

  @override
  String get biometricSuccess => 'Biometria OK';

  @override
  String get biometricWithBackupPin => 'Biometria - z zapasowym PIN-em';

  @override
  String get collection => 'Kolekcja';

  @override
  String get collectionExample => 'np. Kopie zapasowe';

  @override
  String get confirmPattern => 'Narysuj wzór ponownie, aby potwierdzić';

  @override
  String get confirmPin => 'Potwierdź PIN';

  @override
  String get continueText => 'Kontynuuj';

  @override
  String get created => 'Utworzono';

  @override
  String get createVaultKey => 'Utwórz klucz skarbca';

  @override
  String get delete => 'Usuń';

  @override
  String get deleteCollection => 'Usuń kolekcję';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'Usunąć „$name”?\n\nWszystkie wpisy zostaną trwale usunięte.';
  }

  @override
  String get deleteEntry => 'Usuń wpis';

  @override
  String deleteEntryConfirm(Object name) {
    return 'Usunąć „$name”?';
  }

  @override
  String get details => 'Szczegóły';

  @override
  String get drawNewPattern => 'Narysuj nowy wzór';

  @override
  String get drawVaultKey => 'Narysuj klucz skarbca';

  @override
  String get editEntry => 'Edytuj wpis';

  @override
  String get enableVaultWord => 'Włącz hasło skarbca';

  @override
  String get enterPin => 'Wprowadź PIN';

  @override
  String get enterPinHint => 'Wprowadź 5-cyfrowy PIN';

  @override
  String get enterVaultWord => 'Wprowadź hasło skarbca';

  @override
  String get entryDetails => 'Szczegóły wpisu';

  @override
  String get export => 'Eksportuj';

  @override
  String get exportComingNext => 'Eksport wkrótce';

  @override
  String get exportCompleted => 'Eksport zakończony';

  @override
  String get exportData => 'Eksport danych';

  @override
  String get exportPin => 'PIN kopii zapasowej';

  @override
  String get generatePassword => 'Generuj hasło';

  @override
  String get generatePasswordDescription => 'Utwórz silne hasło poniżej. Skopiowanie wypełni też pole hasła.';

  @override
  String get generate => 'Generuj';

  @override
  String get hideSensitiveContent => 'Ukryj wrażliwe dane do odblokowania';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'Skopiowano IBAN';

  @override
  String get import => 'Importuj';

  @override
  String get importCompleted => 'Import zakończony';

  @override
  String get importData => 'Import danych';

  @override
  String get importFailed => 'Błąd importu';

  @override
  String get importPin => 'PIN przywracania';

  @override
  String get language => 'Język';

  @override
  String get lynraSecurity => 'Bezpieczeństwo Lynra';

  @override
  String get max5Collections => 'Maks. 5 kolekcji';

  @override
  String get medium => 'Średni';

  @override
  String get min5Dots => 'Użyj co najmniej 5 punktów';

  @override
  String get modified => 'Zmieniono';

  @override
  String get myVault => 'Mój skarbiec';

  @override
  String get newCollection => 'Nowa kolekcja';

  @override
  String get newEntry => 'Nowy wpis';

  @override
  String get noEntriesYet => 'Brak wpisów';

  @override
  String get none => 'Brak';

  @override
  String get noNoteAdded => 'Brak notatki';

  @override
  String get noPasswordGenerated => 'Hasło jeszcze nie wygenerowane';

  @override
  String get note => 'Notatka';

  @override
  String get noteType => 'Notatka';

  @override
  String get noUsername => 'Brak nazwy użytkownika';

  @override
  String get onboardingDescription => 'Twoje dane pozostają na urządzeniu.\n\nLynraGreyNote nie używa serwerów, nie śledzi Cię i nie zbiera danych.\n\nWszystko jest szyfrowane i przechowywane lokalnie.\nTylko Ty masz dostęp.\n\nUżyj dodatkowego PIN-u lub biometrii do szybkiego i bezpiecznego dostępu.\nWłącz hasło skarbca, aby dodać warstwę prywatności i ukrywać dane w razie potrzeby.';

  @override
  String get optionalNote => 'Notatka opcjonalna';

  @override
  String get password => 'Hasło';

  @override
  String get passwordCopied => 'Hasło skopiowane';

  @override
  String get patternMismatch => 'Wzory nie pasują. Spróbuj ponownie';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN musi mieć 6 cyfr';

  @override
  String get pinSaved => 'PIN zapisany';

  @override
  String get pinsDoNotMatch => 'PIN-y nie pasują';

  @override
  String get privateByDesign => 'Prywatność to podstawa, nie funkcja';

  @override
  String get save => 'Zapisz';

  @override
  String get savePin => 'Zapisz PIN';

  @override
  String get secondaryLock => 'Dodatkowa blokada';

  @override
  String get security => 'Bezpieczeństwo';

  @override
  String get selectLanguage => 'Wybierz język';

  @override
  String get settings => 'Ustawienia';

  @override
  String get setPin => 'Ustaw PIN';

  @override
  String get standard => 'Standardowy';

  @override
  String get strong => 'Silny';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'elementów',
      one: 'element',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'Hasło skarbca';

  @override
  String get weak => 'Słaby';

  @override
  String get wrongPattern => 'Błędny wzór. Spróbuj ponownie';

  @override
  String get wrongPin => 'Błędny PIN';

  @override
  String get title => 'Tytuł';

  @override
  String get unlock => 'Odblokuj';

  @override
  String get unlockContent => 'Odblokuj zawartość';

  @override
  String get unlockVault => 'Odblokuj skarbiec';

  @override
  String get untitled => 'Bez tytułu';

  @override
  String updatedDate(Object date) {
    return 'Zaktualizowano $date';
  }

  @override
  String get username => 'Nazwa użytkownika';

  @override
  String get usernameCopied => 'Nazwa użytkownika skopiowana';

  @override
  String get usernameEmail => 'Nazwa użytkownika / Email';
}
