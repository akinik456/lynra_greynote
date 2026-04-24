// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get removeAttachment => 'إزالة الملف';

  @override
  String get attachmentRemoved => 'تمت إزالة المرفق';

  @override
  String get viewAttachment => 'عرض المرفق';

  @override
  String get addAttachment => 'إضافة مرفق';

  @override
  String get attachmentReady => 'المرفق جاهز';

  @override
  String get attachmentTooLarge => 'الحد الأقصى 2 ميجابايت';

  @override
  String get search => 'بحث';

  @override
  String get unlockToSearch => 'افتح القفل للبحث';

  @override
  String get limitReached => 'تم الوصول إلى الحد';

  @override
  String get freeLimitEntries => 'يمكنك إضافة ما يصل إلى سجلين في النسخة المجانية.';

  @override
  String get upgrade => 'ترقية';

  @override
  String get cancel => 'إلغاء';

  @override
  String get add => 'إضافة';

  @override
  String get addFirstSecureEntry => 'اضغط على زر + لإضافة أول عنصر آمن.';

  @override
  String get addIban => 'إضافة IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'تحقق للمتابعة';

  @override
  String get bankDetails => 'تفاصيل البنك';

  @override
  String get biometric => 'القياسات الحيوية';

  @override
  String get biometricFailed => 'فشل التحقق الحيوي';

  @override
  String get biometricNotAvailable => 'التحقق الحيوي غير متاح';

  @override
  String get biometricSuccess => 'تم التحقق الحيوي';

  @override
  String get biometricWithBackupPin => 'القياسات الحيوية - مع رمز PIN احتياطي';

  @override
  String get collection => 'مجموعة';

  @override
  String get collectionExample => 'مثال: نسخ احتياطية';

  @override
  String get confirmPattern => 'ارسم النمط مرة أخرى للتأكيد';

  @override
  String get confirmPin => 'تأكيد PIN';

  @override
  String get continueText => 'متابعة';

  @override
  String get created => 'تم الإنشاء';

  @override
  String get createVaultKey => 'أنشئ مفتاح الخزنة';

  @override
  String get delete => 'حذف';

  @override
  String get deleteCollection => 'حذف المجموعة';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'حذف \"$name\"؟\n\nسيتم حذف جميع العناصر نهائيًا.';
  }

  @override
  String get deleteEntry => 'حذف العنصر';

  @override
  String deleteEntryConfirm(Object name) {
    return 'حذف \"$name\"؟';
  }

  @override
  String get details => 'التفاصيل';

  @override
  String get drawNewPattern => 'ارسم نمطًا جديدًا';

  @override
  String get drawVaultKey => 'ارسم مفتاح الخزنة';

  @override
  String get editEntry => 'تعديل العنصر';

  @override
  String get enableVaultWord => 'تفعيل كلمة الخزنة';

  @override
  String get enterPin => 'أدخل PIN';

  @override
  String get enterPinHint => 'أدخل PIN مكون من 5 أرقام';

  @override
  String get enterVaultWord => 'أدخل كلمة الخزنة';

  @override
  String get entryDetails => 'تفاصيل العنصر';

  @override
  String get export => 'تصدير';

  @override
  String get exportComingNext => 'التصدير قريبًا';

  @override
  String get exportCompleted => 'تم التصدير';

  @override
  String get exportData => 'تصدير البيانات';

  @override
  String get exportPin => 'PIN النسخ الاحتياطي';

  @override
  String get generatePassword => 'إنشاء كلمة مرور';

  @override
  String get generatePasswordDescription => 'أنشئ كلمة مرور قوية أدناه. النسخ سيملأ الحقل تلقائيًا.';

  @override
  String get generate => 'إنشاء';

  @override
  String get hideSensitiveContent => 'إخفاء المحتوى الحساس حتى يتم الفتح';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'تم نسخ IBAN';

  @override
  String get import => 'استيراد';

  @override
  String get importCompleted => 'تم الاستيراد';

  @override
  String get importData => 'استيراد البيانات';

  @override
  String get importFailed => 'فشل الاستيراد';

  @override
  String get importPin => 'PIN الاستعادة';

  @override
  String get language => 'اللغة';

  @override
  String get lynraSecurity => 'أمان Lynra';

  @override
  String get max5Collections => 'الحد الأقصى 5 مجموعات';

  @override
  String get medium => 'متوسط';

  @override
  String get min5Dots => 'استخدم 5 نقاط على الأقل';

  @override
  String get modified => 'تم التعديل';

  @override
  String get myVault => 'خزنتي';

  @override
  String get newCollection => 'مجموعة جديدة';

  @override
  String get newEntry => 'عنصر جديد';

  @override
  String get noEntriesYet => 'لا توجد عناصر بعد';

  @override
  String get none => 'لا يوجد';

  @override
  String get noNoteAdded => 'لا توجد ملاحظة';

  @override
  String get noPasswordGenerated => 'لم يتم إنشاء كلمة مرور بعد';

  @override
  String get note => 'ملاحظة';

  @override
  String get noteType => 'ملاحظة';

  @override
  String get noUsername => 'لا يوجد اسم مستخدم';

  @override
  String get onboardingDescription => 'بياناتك تبقى على جهازك.\n\nLynraGreyNote لا يستخدم خوادم ولا يتتبعك ولا يجمع أي معلومات.\n\nكل ما تحفظه مشفر ومخزن محليًا.\nأنت الوحيد الذي يمكنه الوصول.\n\nاستخدم PIN ثانوي أو القياسات الحيوية للوصول السريع والآمن.\nفعّل كلمة الخزنة لإضافة طبقة خصوصية وإخفاء المحتوى عند الحاجة.';

  @override
  String get optionalNote => 'ملاحظة اختيارية';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordCopied => 'تم نسخ كلمة المرور';

  @override
  String get patternMismatch => 'الأنماط غير متطابقة. حاول مرة أخرى';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'يجب أن يكون PIN مكونًا من 6 أرقام';

  @override
  String get pinSaved => 'تم حفظ PIN';

  @override
  String get pinsDoNotMatch => 'رموز PIN غير متطابقة';

  @override
  String get privateByDesign => 'الخصوصية أساس وليست ميزة';

  @override
  String get save => 'حفظ';

  @override
  String get savePin => 'حفظ PIN';

  @override
  String get secondaryLock => 'قفل ثانوي';

  @override
  String get security => 'الأمان';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get setPin => 'تعيين PIN';

  @override
  String get standard => 'قياسي';

  @override
  String get strong => 'قوي';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'عناصر',
      one: 'عنصر',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'كلمة الخزنة';

  @override
  String get weak => 'ضعيف';

  @override
  String get wrongPattern => 'نمط خاطئ. حاول مرة أخرى';

  @override
  String get wrongPin => 'PIN غير صحيح';

  @override
  String get title => 'العنوان';

  @override
  String get unlock => 'فتح';

  @override
  String get unlockContent => 'فتح المحتوى';

  @override
  String get unlockVault => 'فتح الخزنة';

  @override
  String get untitled => 'بدون عنوان';

  @override
  String updatedDate(Object date) {
    return 'تم التحديث $date';
  }

  @override
  String get username => 'اسم المستخدم';

  @override
  String get usernameCopied => 'تم نسخ اسم المستخدم';

  @override
  String get usernameEmail => 'اسم المستخدم / البريد الإلكتروني';
}
