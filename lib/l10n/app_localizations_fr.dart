// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get limitReached => 'Limit reached';

  @override
  String get freeLimitEntries => 'You can add up to 2 entries in the free version.';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get cancel => 'Annuler';

  @override
  String get add => 'Ajouter';

  @override
  String get addFirstSecureEntry => 'Appuyez sur + pour ajouter votre première entrée sécurisée';

  @override
  String get addIban => 'Ajouter un IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Authentifiez-vous pour continuer';

  @override
  String get bankDetails => 'Coordonnées bancaires';

  @override
  String get biometric => 'Biométrie';

  @override
  String get biometricFailed => 'Échec de la biométrie';

  @override
  String get biometricNotAvailable => 'Biométrie non disponible';

  @override
  String get biometricSuccess => 'Biométrie réussie';

  @override
  String get biometricWithBackupPin => 'Biométrique - avec PIN de secours';

  @override
  String get collection => 'Collection';

  @override
  String get collectionExample => 'ex. : Sauvegardes';

  @override
  String get confirmPattern => 'Redessinez le même schéma pour confirmer';

  @override
  String get confirmPin => 'Confirmer le code PIN';

  @override
  String get continueText => 'Continuer';

  @override
  String get created => 'Créé';

  @override
  String get createVaultKey => 'Définir votre schéma de sécurité';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteCollection => 'Supprimer la collection';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'Supprimer \"$name\" ?\n\nToutes les entrées seront définitivement supprimées.';
  }

  @override
  String get deleteEntry => 'Supprimer l’entrée';

  @override
  String deleteEntryConfirm(Object name) {
    return 'Supprimer \"$name\" ?';
  }

  @override
  String get details => 'Détails';

  @override
  String get drawNewPattern => 'Dessiner un nouveau schéma';

  @override
  String get drawVaultKey => 'Dessinez votre schéma de sécurité';

  @override
  String get editEntry => 'Modifier l’entrée';

  @override
  String get enableVaultWord => 'Activer le mot du coffre';

  @override
  String get enterPin => 'Saisir le code PIN';

  @override
  String get enterPinHint => 'Saisir un code PIN à 5 chiffres';

  @override
  String get enterVaultWord => 'Saisissez votre mot du coffre';

  @override
  String get entryDetails => 'Détails de l’entrée';

  @override
  String get export => 'Exporter';

  @override
  String get exportComingNext => 'Export bientôt disponible';

  @override
  String get exportCompleted => 'Export terminé';

  @override
  String get exportData => 'Exporter les données';

  @override
  String get exportPin => 'Code PIN de sauvegarde';

  @override
  String get generatePassword => 'Générer un mot de passe';

  @override
  String get generatePasswordDescription => 'Créez un mot de passe sécurisé ci-dessous. En le copiant, il sera également inséré dans le champ mot de passe.';

  @override
  String get generate => 'Générer';

  @override
  String get hideSensitiveContent => 'Masquer le contenu sensible jusqu’au déverrouillage';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN copié';

  @override
  String get import => 'Importer';

  @override
  String get importCompleted => 'Import terminé';

  @override
  String get importData => 'Importer les données';

  @override
  String get importFailed => 'Échec de l’import';

  @override
  String get importPin => 'Code PIN de restauration';

  @override
  String get language => 'Langue';

  @override
  String get lynraSecurity => 'Sécurité Lynra';

  @override
  String get max5Collections => 'Maximum 5 collections autorisées';

  @override
  String get medium => 'Moyen';

  @override
  String get min5Dots => 'Utilisez au moins 5 points';

  @override
  String get modified => 'Modifié';

  @override
  String get myVault => 'Mon coffre';

  @override
  String get newCollection => 'Nouvelle collection';

  @override
  String get newEntry => 'Nouvelle entrée';

  @override
  String get noEntriesYet => 'Aucune entrée pour le mome';

  @override
  String get none => 'Aucun';

  @override
  String get noNoteAdded => 'Aucune note ajoutée';

  @override
  String get noPasswordGenerated => 'Aucun mot de passe généré';

  @override
  String get note => 'Note';

  @override
  String get noteType => 'Note';

  @override
  String get noUsername => 'Aucun identifiant';

  @override
  String get onboardingDescription => 'Vos données restent sur votre appareil.\n\nLynraGreyNote n’utilise pas de serveurs, ne vous suit pas et ne collecte aucune information.\n\nTout ce que vous enregistrez est chiffré et stocké localement.\nVous êtes le seul à pouvoir y accéder.\n\nUtilisez un PIN secondaire ou la biométrie pour un accès rapide et sécurisé.\nActivez le mot du coffre pour ajouter une couche de confidentialité et masquer votre contenu si nécessaire.';

  @override
  String get optionalNote => 'Note optionnelle';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordCopied => 'Mot de passe copié';

  @override
  String get patternMismatch => 'Les schémas ne correspondent pas. Recommencez';

  @override
  String get pin => 'Code PIN';

  @override
  String get pinMustBe6Digits => 'Le PIN doit contenir 6 chiffres';

  @override
  String get pinSaved => 'PIN enregistré';

  @override
  String get pinsDoNotMatch => 'Les PIN ne correspondent pas';

  @override
  String get privateByDesign => 'La confidentialité est essentielle, pas une option';

  @override
  String get save => 'Enregistrer';

  @override
  String get savePin => 'Enregistrer le PIN';

  @override
  String get secondaryLock => 'Verrou secondaire';

  @override
  String get security => 'Sécurité';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get settings => 'Paramètres';

  @override
  String get setPin => 'Définir le code PIN';

  @override
  String get standard => 'Standard';

  @override
  String get strong => 'Fort';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'éléments',
      one: 'élément',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'Mot de sécurité';

  @override
  String get weak => 'Faible';

  @override
  String get wrongPattern => 'Schéma incorrect. Réessayez';

  @override
  String get wrongPin => 'PIN incorrect';

  @override
  String get title => 'Titre';

  @override
  String get unlock => 'Déverrouiller';

  @override
  String get unlockContent => 'Déverrouiller le contenu';

  @override
  String get unlockVault => 'Déverrouiller le coffre';

  @override
  String get untitled => 'Sans titre';

  @override
  String updatedDate(Object date) {
    return 'Mis à jour le $date';
  }

  @override
  String get username => 'Nom d’utilisateur';

  @override
  String get usernameCopied => 'Nom d’utilisateur copié';

  @override
  String get usernameEmail => 'Nom d’utilisateur / Email';
}
