// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get limitReached => 'Limit reached';

  @override
  String get freeLimitEntries => 'You can add up to 2 entries in the free version.';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get add => 'เพิ่ม';

  @override
  String get addFirstSecureEntry => 'แตะปุ่ม + เพื่อเพิ่มรายการที่ปลอดภัยรายการแรก';

  @override
  String get addIban => 'เพิ่ม IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'ยืนยันตัวตนเพื่อดำเนินการต่อ';

  @override
  String get bankDetails => 'ข้อมูลธนาคาร';

  @override
  String get biometric => 'ไบโอเมตริก';

  @override
  String get biometricFailed => 'ไบโอเมตริกล้มเหลว';

  @override
  String get biometricNotAvailable => 'ไม่รองรับไบโอเมตริก';

  @override
  String get biometricSuccess => 'ไบโอเมตริกสำเร็จ';

  @override
  String get biometricWithBackupPin => 'ไบโอเมตริก - พร้อม PIN สำรอง';

  @override
  String get collection => 'คอลเลกชัน';

  @override
  String get collectionExample => 'เช่น สำรองข้อมูล';

  @override
  String get confirmPattern => 'วาดรูปแบบเดิมอีกครั้งเพื่อยืนยัน';

  @override
  String get confirmPin => 'ยืนยัน PIN';

  @override
  String get continueText => 'ดำเนินการต่อ';

  @override
  String get created => 'สร้างแล้ว';

  @override
  String get createVaultKey => 'สร้างกุญแจคลัง';

  @override
  String get delete => 'ลบ';

  @override
  String get deleteCollection => 'ลบคอลเลกชัน';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'ลบ \"$name\"?\n\nรายการทั้งหมดจะถูกลบถาวร';
  }

  @override
  String get deleteEntry => 'ลบรายการ';

  @override
  String deleteEntryConfirm(Object name) {
    return 'ลบ \"$name\"?';
  }

  @override
  String get details => 'รายละเอียด';

  @override
  String get drawNewPattern => 'วาดรูปแบบใหม่';

  @override
  String get drawVaultKey => 'วาดกุญแจคลังของคุณ';

  @override
  String get editEntry => 'แก้ไขรายการ';

  @override
  String get enableVaultWord => 'เปิดใช้คำคลัง';

  @override
  String get enterPin => 'ป้อน PIN';

  @override
  String get enterPinHint => 'ป้อน PIN 5 หลัก';

  @override
  String get enterVaultWord => 'ป้อนคำคลังของคุณ';

  @override
  String get entryDetails => 'รายละเอียดรายการ';

  @override
  String get export => 'ส่งออก';

  @override
  String get exportComingNext => 'กำลังจะมีการส่งออก';

  @override
  String get exportCompleted => 'ส่งออกเสร็จสิ้น';

  @override
  String get exportData => 'ส่งออกข้อมูล';

  @override
  String get exportPin => 'PIN สำรอง';

  @override
  String get generatePassword => 'สร้างรหัสผ่าน';

  @override
  String get generatePasswordDescription => 'สร้างรหัสผ่านที่ปลอดภัยด้านล่าง การคัดลอกจะกรอกลงในช่องรหัสผ่านด้วย';

  @override
  String get generate => 'สร้าง';

  @override
  String get hideSensitiveContent => 'ซ่อนข้อมูลสำคัญจนกว่าจะปลดล็อก';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'คัดลอก IBAN แล้ว';

  @override
  String get import => 'นำเข้า';

  @override
  String get importCompleted => 'นำเข้าเสร็จสิ้น';

  @override
  String get importData => 'นำเข้าข้อมูล';

  @override
  String get importFailed => 'นำเข้าไม่สำเร็จ';

  @override
  String get importPin => 'PIN กู้คืน';

  @override
  String get language => 'ภาษา';

  @override
  String get lynraSecurity => 'ความปลอดภัย Lynra';

  @override
  String get max5Collections => 'สูงสุด 5 คอลเลกชัน';

  @override
  String get medium => 'ปานกลาง';

  @override
  String get min5Dots => 'ใช้อย่างน้อย 5 จุด';

  @override
  String get modified => 'แก้ไขแล้ว';

  @override
  String get myVault => 'คลังของฉัน';

  @override
  String get newCollection => 'คอลเลกชันใหม่';

  @override
  String get newEntry => 'รายการใหม่';

  @override
  String get noEntriesYet => 'ยังไม่มีรายการ';

  @override
  String get none => 'ไม่มี';

  @override
  String get noNoteAdded => 'ยังไม่มีบันทึก';

  @override
  String get noPasswordGenerated => 'ยังไม่มีรหัสผ่าน';

  @override
  String get note => 'บันทึก';

  @override
  String get noteType => 'บันทึก';

  @override
  String get noUsername => 'ไม่มีชื่อผู้ใช้';

  @override
  String get onboardingDescription => 'ข้อมูลของคุณอยู่บนอุปกรณ์เท่านั้น\n\nLynraGreyNote ไม่ใช้เซิร์ฟเวอร์ ไม่ติดตาม และไม่เก็บข้อมูลใด ๆ\n\nทุกอย่างถูกเข้ารหัสและจัดเก็บภายในเครื่อง\nมีเพียงคุณที่เข้าถึงได้\n\nใช้ PIN รองหรือไบโอเมตริกเพื่อเข้าถึงอย่างรวดเร็วและปลอดภัย\nเปิดใช้คำคลังเพื่อเพิ่มความเป็นส่วนตัวและซ่อนข้อมูลเมื่อจำเป็น';

  @override
  String get optionalNote => 'บันทึกเพิ่มเติม';

  @override
  String get password => 'รหัสผ่าน';

  @override
  String get passwordCopied => 'คัดลอกรหัสผ่านแล้ว';

  @override
  String get patternMismatch => 'รูปแบบไม่ตรงกัน เริ่มใหม่';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN ต้องมี 6 หลัก';

  @override
  String get pinSaved => 'บันทึก PIN แล้ว';

  @override
  String get pinsDoNotMatch => 'PIN ไม่ตรงกัน';

  @override
  String get privateByDesign => 'ความเป็นส่วนตัวคือพื้นฐาน ไม่ใช่ฟีเจอร์';

  @override
  String get save => 'บันทึก';

  @override
  String get savePin => 'บันทึก PIN';

  @override
  String get secondaryLock => 'ล็อกเสริม';

  @override
  String get security => 'ความปลอดภัย';

  @override
  String get selectLanguage => 'เลือกภาษา';

  @override
  String get settings => 'ตั้งค่า';

  @override
  String get setPin => 'ตั้งค่า PIN';

  @override
  String get standard => 'มาตรฐาน';

  @override
  String get strong => 'แข็งแรง';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'รายการ',
      one: 'รายการ',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'คำคลัง';

  @override
  String get weak => 'อ่อน';

  @override
  String get wrongPattern => 'รูปแบบไม่ถูกต้อง ลองอีกครั้ง';

  @override
  String get wrongPin => 'PIN ไม่ถูกต้อง';

  @override
  String get title => 'ชื่อ';

  @override
  String get unlock => 'ปลดล็อก';

  @override
  String get unlockContent => 'ปลดล็อกเนื้อหา';

  @override
  String get unlockVault => 'ปลดล็อกคลัง';

  @override
  String get untitled => 'ไม่มีชื่อ';

  @override
  String updatedDate(Object date) {
    return 'อัปเดต $date';
  }

  @override
  String get username => 'ชื่อผู้ใช้';

  @override
  String get usernameCopied => 'คัดลอกชื่อผู้ใช้แล้ว';

  @override
  String get usernameEmail => 'ชื่อผู้ใช้ / อีเมล';
}
