// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

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
  String get cancel => 'Cancel';

  @override
  String get collection => 'Collection';

  @override
  String get collectionExample => 'e.g. Mom';

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

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr(): super('pt_BR');

  @override
  String get add => 'Adicionar';

  @override
  String get addFirstSecureEntry => 'Toque no botão + para adicionar seu primeiro item seguro.';

  @override
  String get addIban => 'Adicionar IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Autentique-se para continuar';

  @override
  String get bankDetails => 'Dados bancários';

  @override
  String get biometric => 'Biometria';

  @override
  String get biometricFailed => 'Falha na biometria';

  @override
  String get biometricNotAvailable => 'Biometria indisponível';

  @override
  String get biometricSuccess => 'Biometria bem-sucedida';

  @override
  String get cancel => 'Cancelar';

  @override
  String get collection => 'Coleção';

  @override
  String get collectionExample => 'ex: Mãe';

  @override
  String get confirmPattern => 'Desenhe o mesmo padrão novamente para confirmar';

  @override
  String get confirmPin => 'Confirmar PIN';

  @override
  String get continueText => 'Continuar';

  @override
  String get created => 'Criado';

  @override
  String get createVaultKey => 'Crie seu padrão de segurança';

  @override
  String get delete => 'Excluir';

  @override
  String get deleteCollection => 'Excluir coleção';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'Excluir \"$name\"?\n\nTodos os itens serão removidos permanentemente.';
  }

  @override
  String get deleteEntry => 'Excluir item';

  @override
  String deleteEntryConfirm(Object name) {
    return 'Excluir \"$name\"?';
  }

  @override
  String get details => 'Detalhes';

  @override
  String get drawNewPattern => 'Desenhe um novo padrão';

  @override
  String get drawVaultKey => 'Desenhe seu padrão de seguranç';

  @override
  String get editEntry => 'Editar item';

  @override
  String get enableVaultWord => 'Ativar palavra de segurança';

  @override
  String get enterPin => 'Inserir PIN';

  @override
  String get enterPinHint => 'Digite um PIN de 5 dígitos';

  @override
  String get enterVaultWord => 'Digite sua palavra de segurança';

  @override
  String get entryDetails => 'Detalhes do item';

  @override
  String get export => 'Exportar';

  @override
  String get exportComingNext => 'Exportação em breve';

  @override
  String get exportCompleted => 'Exportação concluída';

  @override
  String get exportData => 'Exportar dados';

  @override
  String get exportPin => 'PIN de backup';

  @override
  String get hideSensitiveContent => 'Ocultar conteúdo sensível até desbloquear';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN copiado';

  @override
  String get import => 'Importar';

  @override
  String get importCompleted => 'Importação concluída';

  @override
  String get importData => 'Importar dados';

  @override
  String get importFailed => 'Falha na importação';

  @override
  String get importPin => 'PIN de restauração';

  @override
  String get language => 'Idioma';

  @override
  String get lynraSecurity => 'Segurança Lynra';

  @override
  String get max5Collections => 'Máximo de 5 coleções permitido';

  @override
  String get medium => 'Médio';

  @override
  String get min5Dots => 'Use pelo menos 5 pontos';

  @override
  String get modified => 'Modificado';

  @override
  String get myVault => 'Meu cofre';

  @override
  String get newCollection => 'Nova coleção';

  @override
  String get newEntry => 'Novo item';

  @override
  String get noEntriesYet => 'Nenhum item por enquanto';

  @override
  String get none => 'Nenhum';

  @override
  String get noNoteAdded => 'Nenhuma nota adicionada';

  @override
  String get note => 'Nota';

  @override
  String get noteType => 'Nota';

  @override
  String get noUsername => 'Sem nome de usuário';

  @override
  String get onboardingDescription => 'Seus dados permanecem no seu dispositivo.\n\nO LynraGreyNote não usa servidores, não rastreia você e não coleta nenhuma informação.\n\nTudo que você salva é criptografado e armazenado localmente.\nApenas você pode acessá-lo.\n\nUse PIN secundário ou biometria para acesso rápido e seguro.\nAtive a chave da bóveda para adicionar uma camada extra de privacidade e ocultar seu conteúdo quando necessário.';

  @override
  String get optionalNote => 'Nota opcional';

  @override
  String get password => 'Senha';

  @override
  String get passwordCopied => 'Senha copiada';

  @override
  String get patternMismatch => 'Os padrões não coincidem. Tente novamente';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'O PIN deve ter 6 dígitos';

  @override
  String get pinSaved => 'PIN salvo';

  @override
  String get pinsDoNotMatch => 'Os PINs não coincidem';

  @override
  String get privateByDesign => 'Privacidade é fundamental, não um recurso';

  @override
  String get save => 'Salvar';

  @override
  String get savePin => 'Salvar PIN';

  @override
  String get secondaryLock => 'Bloqueio secundário';

  @override
  String get security => 'Segurança';

  @override
  String get selectLanguage => 'Selecionar idioma';

  @override
  String get settings => 'Configurações';

  @override
  String get setPin => 'Definir PIN';

  @override
  String get standard => 'Padrão';

  @override
  String get strong => 'Forte';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'itens',
      one: 'item',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'Palavra de segurança';

  @override
  String get weak => 'Fraco';

  @override
  String get wrongPattern => 'Padrão incorreto. Tente novamente';

  @override
  String get wrongPin => 'PIN incorreto';

  @override
  String get title => 'Título';

  @override
  String get unlock => 'Desbloquear';

  @override
  String get unlockContent => 'Desbloquear conteúdo';

  @override
  String get unlockVault => 'Desbloquear cofre';

  @override
  String get untitled => 'Sem título';

  @override
  String updatedDate(Object date) {
    return 'Atualizado em $date';
  }

  @override
  String get username => 'Nome de usuário';

  @override
  String get usernameCopied => 'Nome de usuário copiado';

  @override
  String get usernameEmail => 'Nome de usuário / E-mail';
}
