// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get shareText => 'Lynra GreyNote - Coffre Privé Hors Ligne. Pas de cloud. Pas de publicité. Pas d’abonnement.';

  @override
  String get add => 'Ajouter';

  @override
  String get addAttachment => 'Ajouter une pièce jointe';

  @override
  String get addFirstSecureEntry => 'Appuyez sur + pour ajouter votre première entrée sécurisée';

  @override
  String get addIban => 'Ajouter un IBAN';

  @override
  String get advancedSecurityBody => 'Lynra GreyNote est conçu selon des principes cryptographiques modernes.\n\nProtection des données:\nLe contenu des entrées est chiffré avec l\'algorithme AES-256-GCM.\nLa base de données est entièrement stockée sous forme chiffrée avec SQLCipher.\n\nGestion des clés:\nLa clé principale (Master Key) est dérivée des clés utilisateur à l\'aide de l\'algorithme PBKDF2-HMAC-SHA256.\nCette clé n\'est jamais stockée en clair et n\'est utilisée que pendant la session active.\n\nSéparation des clés (Key Separation):\nL\'accès à la base de données et le chiffrement des données utilisent des clés différentes.\n\nCouche de sécurité supplémentaire:\nLorsque le Vault Word est activé, les données sont protégées par une deuxième couche.\nCette clé n\'est pas stockée sur l\'appareil et est connue uniquement de l\'utilisateur.\n\nSécurité de session:\nLorsque l\'application passe en arrière-plan, l\'accès est automatiquement verrouillé.\nLes clés de chiffrement ne sont conservées en mémoire que pendant le traitement.\n\nSécurité de l\'écran:\nLes captures d\'écran et les enregistrements d\'écran sont bloqués au niveau système.\n\nSauvegarde:\nLors de l\'exportation, les données sont créées sous forme de bloc chiffré (encrypted blob) et ne peuvent être restaurées qu\'avec les informations correctes.\n\nLynra ne peut pas accéder aux données des utilisateurs, ni les lire ou les récupérer.\n\nTout le modèle de sécurité est basé sur le fait que les données sont entièrement contrôlées par l\'utilisateur.';

  @override
  String get advancedSecurityTitle => 'Sécurité avancée';

  @override
  String get alreadyExists => 'Cet élément existe déjà';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get attachmentReady => 'Pièce jointe prête';

  @override
  String get attachmentRemoved => 'Pièce jointe supprimée';

  @override
  String get attachmentTooLarge => 'Maximum 5 Mo';

  @override
  String get authenticateToContinue => 'Authentifiez-vous pour continuer';

  @override
  String get backupReminder => 'Pensez à créer une sauvegarde pour protéger vos données';

  @override
  String get backupPatternWarning => 'Le même schéma de verrouillage est requis pour importer cette sauvegarde.';

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
  String get cancel => 'Annuler';

  @override
  String get clear => 'Effacer';

  @override
  String get clearMyVault => 'Effacer Mon Coffre';

  @override
  String get clearMyVaultConfirm => 'Cela supprimera toutes les entrées de Mon Coffre. Cette action est irréversible.';

  @override
  String get close => 'Fermer';

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
  String get csvimportfailed => 'Échec de l\'importation CSV.';

  @override
  String get csvTemplate => 'Modèle CSV';

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
  String get disable => 'Désactiver';

  @override
  String get disableVaultWord => 'Désactiver le mot du coffre';

  @override
  String get downloadTemplate => 'Télécharger le modèle';

  @override
  String get drawNewPattern => 'Dessiner un nouveau schéma';

  @override
  String get drawVaultKey => 'Dessinez votre schéma de sécurité';

  @override
  String get duplicate => 'Dupliqué';

  @override
  String get editEntry => 'Modifier l’entrée';

  @override
  String get earlysupporter => 'Programme de soutien au lancement';

  @override
  String get earlysupporterText => 'Spécial Lancement : Aidez-nous à améliorer Lynra GreyNote ! 💙\nSi vous trouvez l\'application utile, vous pouvez soutenir notre développement en laissant un avis honnête sur le Play Store.\nAprès avoir rédigé votre avis, envoyez-nous simplement votre nom d\'utilisateur Play Store par e-mail via Paramètres → Commentaires. En exclusivité pour la première semaine, nous offrons un code d\'accès Premium à vie à nos premiers contributeurs ! 🙂';

  @override
  String get empty => 'Vide';

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
  String get exportBackup => 'Exporter une sauvegarde chiffrée';

  @override
  String get exportComingNext => 'Export bientôt disponible';

  @override
  String get exportCompleted => 'Export terminé';

  @override
  String get exportCSV => 'Exporter en fichier CSV';

  @override
  String get exportData => 'Exporter les données';

  @override
  String get exportPin => 'Code PIN de sauvegarde';

  @override
  String get exportText => 'Exporter en fichier texte';

  @override
  String get feedback => 'Retour';

  @override
  String get freeLimitEntries => 'Vous pouvez ajouter jusqu’à 2 entrées dans la version gratuite.';

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
  String get imported => 'Importé';

  @override
  String get importBackup => 'Importer une sauvegarde chiffrée';

  @override
  String get importCompleted => 'Import terminé';

  @override
  String get importCSV => 'Importer depuis un fichier CSV';

  @override
  String get importData => 'Importer les données';

  @override
  String get importFailed => 'Échec de l’import';

  @override
  String get importPin => 'Code PIN de restauration';

  @override
  String get importText => 'Importer depuis un fichier texte';

  @override
  String get language => 'Langue';

  @override
  String get limitReached => 'Limite atteint';

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
  String get myVaultCleared => 'Coffre effacé';

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
  String get pattern => 'Schéma';

  @override
  String get patternMismatch => 'Les schémas ne correspondent pas. Recommencez';

  @override
  String get patternSkipped => 'Motif ignoré';

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
  String get rateOnPlayStore => 'Noter';

  @override
  String get removeAttachment => 'Supprimer le fichier';

  @override
  String get save => 'Enregistrer';

  @override
  String get savePin => 'Enregistrer le PIN';

  @override
  String get search => 'Rechercher';

  @override
  String get secondaryLock => 'Verrou secondaire';

  @override
  String get security => 'Sécurité';

  @override
  String get securityManifesto => 'Modèle de sécurité';

  @override
  String get securitySummaryBody => 'Lynra GreyNote est un coffre sécurisé hors ligne qui stocke vos données uniquement sur votre appareil.\nL\'application n\'utilise aucun serveur, ne vous suit pas et ne collecte aucune donnée.\nToutes vos entrées sont protégées par un chiffrement fort et ne sont accessibles que par vous.\nLorsque l\'application passe en arrière-plan, elle se verrouille automatiquement et les captures d\'écran sont bloquées.\nSi les informations de déverrouillage sont oubliées, les données ne peuvent pas être récupérées.\nPour des informations techniques détaillées, veuillez consulter la section Sécurité avancée ci-dessous.';

  @override
  String get securitySummaryTitle => 'Résumé de sécurité';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get settings => 'Paramètres';

  @override
  String get setPin => 'Définir le code PIN';

  @override
  String get share => 'Partager';

  @override
  String get sort => 'Trier';

  @override
  String get sortFavorites => 'Favoris';

  @override
  String get sortUpdated => 'Dernière mise à jour';

  @override
  String get sortAZ => 'A–Z';

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
  String get viewAttachment => 'Voir la pièce jointe';

  @override
  String get wrongPattern => 'Schéma incorrect. Réessayez';

  @override
  String get wrongPin => 'PIN incorrect';

  @override
  String get textTemplate => 'Modèle de texte';

  @override
  String get title => 'Titre';

  @override
  String get txtImportCompleted => 'Importation terminée.';

  @override
  String get txtImportCompletedWithSkip => 'Importation terminée. %d entrées de motif ont été ignorées.';

  @override
  String get txtExportCompletedWithSkip => 'Exportation terminée. Ce fichier n\'est pas chiffré. %d entrées de motif ont été ignorées.';

  @override
  String get txtExportCompleted => 'Exportation terminée. Ce fichier n’est pas chiffré.';

  @override
  String get unlock => 'Déverrouiller';

  @override
  String get unlockContent => 'Déverrouiller le contenu';

  @override
  String get unlockVault => 'Déverrouiller le coffre';

  @override
  String get unlockToSearch => 'Déverrouillez pour rechercher';

  @override
  String get upgrade => 'Passer à Premium';

  @override
  String get untitled => 'Sans titre';

  @override
  String updatedDate(Object date) {
    return 'Mis à jour le $date';
  }

  @override
  String get usageGuide => 'Guide d\'utilisation';

  @override
  String get usageGuideText => '• Vos données sont stockées uniquement sur votre appareil.\n\n• Des sauvegardes régulières sont recommandées pour protéger vos données lors d’un changement d’appareil ou dans des situations similaires.\n\n• Les entrées de motif sont exclues des fichiers d’exportation pour des raisons de sécurité.\n\n• Le Mot du Coffre masque le contenu sensible à l’écran.\n\n• L’application se verrouille automatiquement lorsqu’elle passe en arrière-plan.\n\n• Cette application n’utilise ni synchronisation cloud ni serveurs externes.\n\n• Pour les opérations d’importation, téléchargez d’abord le fichier modèle approprié et créez vos enregistrements en conséquence.\n\n• Appuyez longuement sur une entrée ou une collection pour la supprimer.';

  @override
  String get username => 'Nom d’utilisateur';

  @override
  String get usernameCopied => 'Nom d’utilisateur copié';

  @override
  String get usernameEmail => 'Nom d’utilisateur / Email';
}
