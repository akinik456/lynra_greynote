// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get pattern => 'Patrón';

  @override
  String get removeAttachment => 'Eliminar archivo';

  @override
  String get attachmentRemoved => 'Adjunto eliminado';

  @override
  String get viewAttachment => 'Ver adjunto';

  @override
  String get addAttachment => 'Agregar adjunto';

  @override
  String get attachmentReady => 'Adjunto listo';

  @override
  String get attachmentTooLarge => 'Máximo 2 MB';

  @override
  String get search => 'Buscar';

  @override
  String get unlockToSearch => 'Desbloquea para buscar';

  @override
  String get limitReached => 'Límite alcanzado';

  @override
  String get freeLimitEntries => 'Puedes añadir hasta 2 registros en la versión gratuita.';

  @override
  String get upgrade => 'Actualizar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get add => 'Añadir';

  @override
  String get addFirstSecureEntry => 'Toca el botón + para añadir tu primera entrada segura.';

  @override
  String get addIban => 'Añadir IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Autentícate para continuar';

  @override
  String get bankDetails => 'Datos bancarios';

  @override
  String get biometric => 'Biometría';

  @override
  String get biometricFailed => 'Error en la autenticación';

  @override
  String get biometricNotAvailable => 'La autenticación biométrica no está disponible';

  @override
  String get biometricSuccess => 'Autenticación correcta';

  @override
  String get biometricWithBackupPin => 'Biométrico - con PIN de respaldo';

  @override
  String get collection => 'Colección';

  @override
  String get collectionExample => 'p. ej., Copias de seguridad';

  @override
  String get confirmPattern => 'Dibuja el mismo patrón otra vez para confirmar';

  @override
  String get confirmPin => 'Confirma el PIN';

  @override
  String get continueText => 'Continuar';

  @override
  String get created => 'Creado el';

  @override
  String get createVaultKey => 'Crea tu clave de bóveda';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteCollection => 'Eliminar colección';

  @override
  String deleteCollectionConfirm(Object name) {
    return '¿Eliminar \"$name\"?\n\nTodas las entradas se eliminarán permanentemente.';
  }

  @override
  String get deleteEntry => 'Eliminar entrada';

  @override
  String deleteEntryConfirm(Object name) {
    return '¿Eliminar \"$name\"?';
  }

  @override
  String get details => 'Detalles';

  @override
  String get drawNewPattern => 'Dibuja un nuevo patrón';

  @override
  String get drawVaultKey => 'Dibuja tu patrón de seguridad';

  @override
  String get editEntry => 'Editar entrada';

  @override
  String get enableVaultWord => 'Activar clave de la bóveda';

  @override
  String get enterPin => 'Introduce el PIN';

  @override
  String get enterPinHint => 'Introduce un PIN de 5 dígitos';

  @override
  String get enterVaultWord => 'Introduce tu clave de bóveda';

  @override
  String get entryDetails => 'Detalles de la entrada';

  @override
  String get export => 'Exportar';

  @override
  String get exportComingNext => 'Exportación disponible próximamente';

  @override
  String get exportCompleted => 'Exportación completada correctamente';

  @override
  String get exportData => 'Exportar datos';

  @override
  String get exportPin => 'PIN de copia de seguridad';

  @override
  String get generatePassword => 'Generar contraseña';

  @override
  String get generatePasswordDescription => 'Crea una contraseña segura a continuación. Al copiarla, también se insertará en el campo de contraseña.';

  @override
  String get generate => 'Generar';

  @override
  String get hideSensitiveContent => 'Ocultar contenido sensible hasta desbloquear';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN copiado';

  @override
  String get import => 'Importar';

  @override
  String get importCompleted => 'Importación completada correctamente';

  @override
  String get importData => 'Importar datos';

  @override
  String get importFailed => 'Error al importar';

  @override
  String get importPin => 'PIN de restauración';

  @override
  String get language => 'Idioma';

  @override
  String get lynraSecurity => 'Seguridad Lynra';

  @override
  String get max5Collections => 'Máximo 5 colecciones permitidas';

  @override
  String get medium => 'Media';

  @override
  String get min5Dots => 'Usa al menos 5 puntos';

  @override
  String get modified => 'Actualizado el';

  @override
  String get myVault => 'Mi Bóveda';

  @override
  String get newCollection => 'Nueva colección';

  @override
  String get newEntry => 'Nueva entrada';

  @override
  String get noEntriesYet => 'Aún no hay entradas';

  @override
  String get none => 'Ninguno';

  @override
  String get noNoteAdded => 'No hay nota añadida';

  @override
  String get noPasswordGenerated => 'Aún no se ha generado ninguna contraseña';

  @override
  String get note => 'Nota';

  @override
  String get noteType => 'Nota';

  @override
  String get noUsername => 'Sin nombre de usuario';

  @override
  String get onboardingDescription => 'Tus datos permanecen en tu dispositivo.\n\nLynraGreyNote no utiliza servidores, no te rastrea y no recopila información.\n\nTodo lo que guardas se cifra y se almacena localmente.\nSolo tú puedes acceder a ello.\n\nUsa PIN secundario o biometría para un acceso rápido y seguro.\nActiva la clave de bóveda para añadir una capa extra de privacidad y ocultar tu contenido cuando sea necesario.';

  @override
  String get optionalNote => 'Nota opcional';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordCopied => 'Contraseña copiada';

  @override
  String get patternMismatch => 'Los patrones no coinciden. Inténtalo de nuevo';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'El PIN debe tener 6 dígitos';

  @override
  String get pinSaved => 'PIN guardado';

  @override
  String get pinsDoNotMatch => 'Los PIN no coinciden';

  @override
  String get privateByDesign => 'La privacidad es fundamental, no una función';

  @override
  String get save => 'Guardar';

  @override
  String get savePin => 'Guardar PIN';

  @override
  String get secondaryLock => 'Bloqueo secundario';

  @override
  String get security => 'Seguridad';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get settings => 'Configuración';

  @override
  String get setPin => 'Configurar PIN';

  @override
  String get standard => 'Estándar';

  @override
  String get strong => 'Fuerte';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'elementos',
      one: 'elemento',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'Clave de la bóveda';

  @override
  String get weak => 'Débil';

  @override
  String get wrongPattern => 'Patrón incorrecto. Inténtalo de nuevo';

  @override
  String get wrongPin => 'PIN incorrecto';

  @override
  String get title => 'Título';

  @override
  String get unlock => 'Desbloquear';

  @override
  String get unlockContent => 'Desbloquear contenido';

  @override
  String get unlockVault => 'Desbloquear bóveda';

  @override
  String get untitled => 'Sin título';

  @override
  String updatedDate(Object date) {
    return 'Actualizado $date';
  }

  @override
  String get username => 'Nombre de usuario';

  @override
  String get usernameCopied => 'Nombre de usuario copiado';

  @override
  String get usernameEmail => 'Nombre de usuario / Correo electrónico';

  @override
  String get securityManifesto => 'Modelo de Seguridad';

  @override
  String get securitySummaryTitle => 'Resumen de Seguridad';

  @override
  String get advancedSecurityTitle => 'Seguridad Avanzada';

  @override
  String get securitySummaryBody => 'Lynra GreyNote es una bóveda segura sin conexión que almacena sus datos únicamente en su dispositivo.\nLa aplicación no utiliza servidores, no le rastrea y no recopila ningún dato.\nTodos sus registros están protegidos con un cifrado fuerte y solo usted puede acceder a ellos.\nCuando la aplicación pasa a segundo plano, se bloquea automáticamente y evita capturas de pantalla.\nSi se olvidan las credenciales de desbloqueo, los datos no pueden recuperarse.\nPara obtener información técnica detallada, consulte la sección de Seguridad Avanzada a continuación.';

  @override
  String get advancedSecurityBody => 'Lynra GreyNote está diseñado de acuerdo con los principios modernos de criptografía.\n\nProtección de Datos:\nEl contenido de los registros se cifra utilizando el algoritmo AES-256-GCM.\nLa base de datos se almacena completamente cifrada utilizando SQLCipher.\n\nGestión de Claves:\nLa clave maestra se deriva de los secretos del usuario utilizando el algoritmo PBKDF2-HMAC-SHA256.\nEsta clave nunca se almacena en texto plano y solo se utiliza durante una sesión activa.\n\nSeparación de Claves:\nEl acceso a la base de datos y las operaciones de cifrado de datos se realizan con claves separadas.\n\nCapa de Seguridad Adicional:\nCuando la función Vault Word está activada, sus datos se protegen con una segunda capa.\nEsta clave no se almacena en el dispositivo y solo la conoce el usuario.\n\nSeguridad de Sesión:\nCuando la aplicación pasa a segundo plano, el acceso se bloquea automáticamente.\nLas claves de cifrado permanecen en memoria solo durante la operación.\n\nSeguridad de Pantalla:\nLas capturas de pantalla y grabaciones se bloquean a nivel del sistema.\n\nCopia de Seguridad:\nLos datos se exportan como un blob cifrado y solo pueden restaurarse con las credenciales correctas.\n\nLynra no puede acceder, leer ni recuperar sus datos.\n\nTodo el modelo de seguridad está basado en el control del usuario.';
}
