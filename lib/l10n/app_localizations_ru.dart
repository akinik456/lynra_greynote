// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get add => 'Добавить';

  @override
  String get addFirstSecureEntry => 'Нажмите +, чтобы добавить первую запись.';

  @override
  String get addIban => 'Добавить IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Подтвердите для продолжения';

  @override
  String get bankDetails => 'Банковские данные';

  @override
  String get biometric => 'Биометрия';

  @override
  String get biometricFailed => 'Сбой биометрии';

  @override
  String get biometricNotAvailable => 'Биометрия недоступна';

  @override
  String get biometricSuccess => 'Биометрия успешна';

  @override
  String get biometricWithBackupPin => 'Biometric with PIN backup';

  @override
  String get biometricWithBackupPinDescription => 'Use biometric for quick access, PIN if needed.';

  @override
  String get cancel => 'Отмена';

  @override
  String get collection => 'Коллекция';

  @override
  String get collectionExample => 'например: Резервные копии';

  @override
  String get confirmPattern => 'Повторите рисунок для подтверждения';

  @override
  String get confirmPin => 'Подтвердите PIN';

  @override
  String get continueText => 'Продолжить';

  @override
  String get created => 'Создано';

  @override
  String get createVaultKey => 'Создайте ключ хранилища';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteCollection => 'Удалить коллекцию';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'Удалить «$name»?\n\nВсе записи будут удалены навсегда.';
  }

  @override
  String get deleteEntry => 'Удалить запись';

  @override
  String deleteEntryConfirm(Object name) {
    return 'Удалить «$name»?';
  }

  @override
  String get details => 'Детали';

  @override
  String get drawNewPattern => 'Нарисуйте новый рисунок';

  @override
  String get drawVaultKey => 'Нарисуйте ключ хранилища';

  @override
  String get editEntry => 'Редактировать запись';

  @override
  String get enableVaultWord => 'Включить кодовое слово';

  @override
  String get enterPin => 'Введите PIN';

  @override
  String get enterPinHint => 'Введите 5-значный PIN';

  @override
  String get enterVaultWord => 'Введите кодовое слово';

  @override
  String get entryDetails => 'Детали записи';

  @override
  String get export => 'Экспорт';

  @override
  String get exportComingNext => 'Экспорт скоро';

  @override
  String get exportCompleted => 'Экспорт завершён';

  @override
  String get exportData => 'Экспорт данных';

  @override
  String get exportPin => 'PIN для резервной копии';

  @override
  String get generatePassword => 'Сгенерировать пароль';

  @override
  String get generatePasswordDescription => 'Создайте надёжный пароль. Копирование также заполнит поле.';

  @override
  String get generate => 'Сгенерировать';

  @override
  String get hideSensitiveContent => 'Скрыть данные до разблокировки';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN скопирован';

  @override
  String get import => 'Импорт';

  @override
  String get importCompleted => 'Импорт завершён';

  @override
  String get importData => 'Импорт данных';

  @override
  String get importFailed => 'Ошибка импорта';

  @override
  String get importPin => 'PIN восстановления';

  @override
  String get language => 'Язык';

  @override
  String get lynraSecurity => 'Lynra Безопасность';

  @override
  String get max5Collections => 'Максимум 5 коллекций';

  @override
  String get medium => 'Средний';

  @override
  String get min5Dots => 'Минимум 5 точек';

  @override
  String get modified => 'Изменено';

  @override
  String get myVault => 'Моё хранилище';

  @override
  String get newCollection => 'Новая коллекция';

  @override
  String get newEntry => 'Новая запись';

  @override
  String get noEntriesYet => 'Записей нет';

  @override
  String get none => 'Нет';

  @override
  String get noNoteAdded => 'Заметка не добавлена';

  @override
  String get noPasswordGenerated => 'Пароль ещё не создан';

  @override
  String get note => 'Заметка';

  @override
  String get noteType => 'Заметка';

  @override
  String get noUsername => 'Нет имени пользователя';

  @override
  String get onboardingDescription => 'Данные хранятся только на вашем устройстве.\n\nLynraGreyNote не использует серверы, не отслеживает вас и не собирает данные.\n\nВсё сохраняется в зашифрованном виде локально.\nТолько вы имеете доступ.\n\nИспользуйте дополнительный PIN или биометрию для быстрого доступа.\nВключите кодовое слово для дополнительной защиты и скрытия данных.';

  @override
  String get optionalNote => 'Доп. заметка';

  @override
  String get password => 'Пароль';

  @override
  String get passwordCopied => 'Пароль скопирован';

  @override
  String get patternMismatch => 'Рисунки не совпали. Повторите';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN должен быть из 6 цифр';

  @override
  String get pinSaved => 'PIN сохранён';

  @override
  String get pinsDoNotMatch => 'PIN не совпадают';

  @override
  String get privateByDesign => 'Приватность — основа, а не функция';

  @override
  String get save => 'Сохранить';

  @override
  String get savePin => 'Сохранить PIN';

  @override
  String get secondaryLock => 'Доп. защита';

  @override
  String get security => 'Безопасность';

  @override
  String get selectLanguage => 'Выбрать язык';

  @override
  String get settings => 'Настройки';

  @override
  String get setPin => 'Установить PIN';

  @override
  String get standard => 'Стандарт';

  @override
  String get strong => 'Сильный';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'элементов',
      one: 'элемент',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'Кодовое слово';

  @override
  String get weak => 'Слабый';

  @override
  String get wrongPattern => 'Неверный рисунок. Повторите';

  @override
  String get wrongPin => 'Неверный PIN';

  @override
  String get title => 'Заголовок';

  @override
  String get unlock => 'Разблокировать';

  @override
  String get unlockContent => 'Открыть содержимое';

  @override
  String get unlockVault => 'Открыть хранилище';

  @override
  String get untitled => 'Без названия';

  @override
  String updatedDate(Object date) {
    return 'Обновлено $date';
  }

  @override
  String get username => 'Имя пользователя';

  @override
  String get usernameCopied => 'Имя пользователя скопировано';

  @override
  String get usernameEmail => 'Имя пользователя / Email';
}
