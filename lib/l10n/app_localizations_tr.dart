// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get limitReached => 'Limit reached';

  @override
  String get freeLimitEntries => 'You can add up to 2 entries in the free version.';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get cancel => 'İptal';

  @override
  String get add => 'Ekle';

  @override
  String get addFirstSecureEntry => 'İlk güvenli kaydını eklemek için + butonuna dokun.';

  @override
  String get addIban => 'IBAN Ekle';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Devam etmek için doğrulayın';

  @override
  String get bankDetails => 'Banka Bilgileri';

  @override
  String get biometric => 'Biyometrik';

  @override
  String get biometricFailed => 'Doğrulama başarısız';

  @override
  String get biometricNotAvailable => 'Biyometrik doğrulama kullanılamıyor';

  @override
  String get biometricSuccess => 'Doğrulama başarılı';

  @override
  String get biometricWithBackupPin => 'Biyometrik - PIN yedekli';

  @override
  String get collection => 'Koleksiyon';

  @override
  String get collectionExample => 'örn. Yedek';

  @override
  String get confirmPattern => 'Onaylamak için aynı deseni tekrar çiz';

  @override
  String get confirmPin => 'PIN Onayla';

  @override
  String get continueText => 'Devam Et';

  @override
  String get created => 'Oluşturulma';

  @override
  String get createVaultKey => 'Kasa Anahtarı Oluştur';

  @override
  String get delete => 'Sil';

  @override
  String get deleteCollection => 'Koleksiyonu Sil';

  @override
  String deleteCollectionConfirm(Object name) {
    return '\"$name\" silinsin mi?\n\nTüm kayıtlar kalıcı olarak silinecek.';
  }

  @override
  String get deleteEntry => 'Kaydı Sil';

  @override
  String deleteEntryConfirm(Object name) {
    return '\"$name\" silinsin mi?';
  }

  @override
  String get details => 'Detaylar';

  @override
  String get drawNewPattern => 'Yeni bir desen çiz';

  @override
  String get drawVaultKey => 'Kasa anahtarını çiz';

  @override
  String get editEntry => 'Kaydı Düzenle';

  @override
  String get enableVaultWord => 'Kasa Anahtarını Etkinleştir';

  @override
  String get enterPin => 'PIN Gir';

  @override
  String get enterPinHint => '5 haneli PIN gir';

  @override
  String get enterVaultWord => 'Kasa anahtarını gir';

  @override
  String get entryDetails => 'Kayıt Detayı';

  @override
  String get export => 'Dışa Aktar';

  @override
  String get exportComingNext => 'Dışa aktarma yakında';

  @override
  String get exportCompleted => 'Dışa aktarma tamamlandı';

  @override
  String get exportData => 'Veriyi Dışa Aktar';

  @override
  String get exportPin => 'Yedekleme PIN’i';

  @override
  String get generatePassword => 'Şifre oluştur';

  @override
  String get generatePasswordDescription => 'Aşağıda güçlü bir şifre oluşturun. Kopyaladığınızda şifre alanına da yazılır.';

  @override
  String get generate => 'Oluştur';

  @override
  String get hideSensitiveContent => 'Hassas içerikleri kilit açılana kadar gizle';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN kopyalandı';

  @override
  String get import => 'İçe Aktar';

  @override
  String get importCompleted => 'İçe aktarma tamamlandı';

  @override
  String get importData => 'Veriyi İçe Aktar';

  @override
  String get importFailed => 'İçe aktarma başarısız';

  @override
  String get importPin => 'Geri Yükleme PIN’i';

  @override
  String get language => 'Dil';

  @override
  String get lynraSecurity => 'Lynra Güvenlik';

  @override
  String get max5Collections => 'En fazla 5 koleksiyon eklenebilir';

  @override
  String get medium => 'Orta';

  @override
  String get min5Dots => 'En az 5 nokta kullan';

  @override
  String get modified => 'Güncellenme';

  @override
  String get myVault => 'Kasam';

  @override
  String get newCollection => 'Yeni Koleksiyon';

  @override
  String get newEntry => 'Yeni Kayıt';

  @override
  String get noEntriesYet => 'Henüz kayıt yok';

  @override
  String get none => 'Yok';

  @override
  String get noNoteAdded => 'Not eklenmemiş';

  @override
  String get noPasswordGenerated => 'Henüz şifre oluşturulmadı';

  @override
  String get note => 'Not';

  @override
  String get noteType => 'Not';

  @override
  String get noUsername => 'Kullanıcı adı yok';

  @override
  String get onboardingDescription => 'Verileriniz cihazınızda kalır.\n\nLynraGreyNote sunucu kullanmaz, sizi takip etmez ve hiçbir veri toplamaz.\n\nKaydettiğiniz her şey şifrelenir ve cihazda saklanır.\nSadece siz erişebilirsiniz.\n\nHızlı ve güvenli erişim için PIN veya Biyometri kullanabilirsiniz.\nEkstra gizlilik için Kasa Anahtarı özelliğini açabilirsiniz.';

  @override
  String get optionalNote => 'Opsiyonel not';

  @override
  String get password => 'Şifre';

  @override
  String get passwordCopied => 'Şifre kopyalandı';

  @override
  String get patternMismatch => 'Desenler eşleşmedi. Tekrar başla';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN 6 haneli olmalı';

  @override
  String get pinSaved => 'PIN kaydedildi';

  @override
  String get pinsDoNotMatch => 'PIN\'ler eşleşmiyor';

  @override
  String get privateByDesign => 'Gizlilik Özellik Değil Temeldir';

  @override
  String get save => 'Kaydet';

  @override
  String get savePin => 'PIN Kaydet';

  @override
  String get secondaryLock => 'İkincil Kilit';

  @override
  String get security => 'Güvenlik';

  @override
  String get selectLanguage => 'Dil Seç';

  @override
  String get settings => 'Ayarlar';

  @override
  String get setPin => 'PIN Ayarla';

  @override
  String get standard => 'Standart';

  @override
  String get strong => 'Güçlü';

  @override
  String vaultHeaderStats(Object collection, int count) {
    return '$collection • $count öğe';
  }

  @override
  String get vaultWord => 'Kasa Kelimesi';

  @override
  String get weak => 'Zayıf';

  @override
  String get wrongPattern => 'Yanlış desen. Tekrar dene';

  @override
  String get wrongPin => 'Yanlış PIN';

  @override
  String get title => 'Başlık';

  @override
  String get unlock => 'Kilidi Aç';

  @override
  String get unlockContent => 'İçeriğin Kilidini Aç';

  @override
  String get unlockVault => 'Kasayı Aç';

  @override
  String get untitled => 'Başlıksız';

  @override
  String updatedDate(Object date) {
    return 'Güncellendi $date';
  }

  @override
  String get username => 'Kullanıcı Adı';

  @override
  String get usernameCopied => 'Kullanıcı adı kopyalandı';

  @override
  String get usernameEmail => 'Kullanıcı Adı / E-posta';
}
