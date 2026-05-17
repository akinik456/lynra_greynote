// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get add => 'Ekle';

  @override
  String get addAttachment => 'Dosya ekle';

  @override
  String get addFirstSecureEntry => 'İlk güvenli kaydını eklemek için + butonuna dokun.';

  @override
  String get addIban => 'IBAN Ekle';

  @override
  String get advancedSecurityBody => 'Lynra GreyNote, modern kriptografi prensiplerine uygun olarak tasarlanmıştır.\n\nVeri Koruma:\nKayıt içerikleri AES-256-GCM algoritması ile şifrelenir.\nVeritabanı SQLCipher kullanılarak tamamen şifreli şekilde saklanır.\n\nAnahtar Yönetimi:\nAna anahtar (Master Key), kullanıcı anahtarlarından PBKDF2-HMAC-SHA256 algoritması ile türetilir.\nBu anahtar hiçbir zaman açık şekilde saklanmaz ve yalnızca aktif oturum sırasında kullanılır.\n\nAnahtar Ayrımı (Key Separation):\nVeritabanı erişimi ve veri şifreleme işlemleri farklı anahtarlarla gerçekleştirilir.\n\nEk Güvenlik Katmanı:\nKasa Anahtarı (Vault Word) etkinleştirildiğinde, veriler ikinci bir katmanla korunur.\nBu anahtar cihazda saklanmaz ve yalnızca kullanıcı tarafından bilinir.\n\nOturum Güvenliği:\nUygulama arka plana alındığında erişim otomatik olarak kilitlenir.\nŞifreleme anahtarları bellekte yalnızca işlem süresi boyunca tutulur.\n\nEkran Güvenliği:\nEkran görüntüsü ve ekran kaydı sistem seviyesinde engellenir.\n\nYedekleme:\nVeriler dışa aktarılırken şifreli bir veri bloğu (encrypted blob) olarak oluşturulur ve yalnızca doğru bilgilerle geri yüklenebilir.\n\nLynra, kullanıcı verilerine erişemez, okuyamaz veya kurtaramaz.\n\nTüm güvenlik modeli, verilerin yalnızca kullanıcı tarafından kontrol edilmesi üzerine kuruludur.';

  @override
  String get advancedSecurityTitle => 'Gelişmiş Güvenlik';

  @override
  String get alreadyExists => 'Bu kayıt zaten mevcut';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get attachmentReady => 'Ek hazır';

  @override
  String get attachmentRemoved => 'Ek kaldırıldı';

  @override
  String get attachmentTooLarge => 'Maksimum 5 MB';

  @override
  String get authenticateToContinue => 'Devam etmek için doğrulayın';

  @override
  String get backupReminder => 'Verilerinizi güvende tutmak için yedek almayı unutmayın';

  @override
  String get backupPatternWarning => 'Bu yedeği içe aktarmak için aynı desen gereklidir.';

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
  String get cancel => 'İptal';

  @override
  String get clear => 'Temizle';

  @override
  String get clearMyVault => 'Kasamı Temizle';

  @override
  String get clearMyVaultConfirm => 'Bu işlem Kasamdaki tüm kayıtları silecektir. Bu işlem geri alınamaz.';

  @override
  String get close => 'Close';

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
  String get csvimportfailed => 'CSV içe aktarma başarısız oldu.';

  @override
  String get csvTemplate => 'CSV Şablonu';

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
  String get disable => 'Devre Dışı Bırak';

  @override
  String get disableVaultWord => 'Kasa Kelimesini Devre Dışı Bırak';

  @override
  String get downloadTemplate => 'Şablonu İndir';

  @override
  String get drawNewPattern => 'Yeni bir desen çiz';

  @override
  String get drawVaultKey => 'Kasa anahtarını çiz';

  @override
  String get duplicate => 'Kopya';

  @override
  String get editEntry => 'Kaydı Düzenle';

  @override
  String get empty => 'Boş';

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
  String get exportBackup => 'Şifreli Yedek Olarak Dışa Aktar';

  @override
  String get exportComingNext => 'Dışa aktarma yakında';

  @override
  String get exportCompleted => 'Dışa aktarma tamamlandı';

  @override
  String get exportCSV => 'CSV dosyası olarak dışa aktar';

  @override
  String get exportData => 'Veriyi Dışa Aktar';

  @override
  String get exportPin => 'Yedekleme PIN’i';

  @override
  String get exportText => 'Metin Dosyası Olarak Dışa Aktar';

  @override
  String get feedback => 'Geri Bildirim';

  @override
  String get freeLimitEntries => 'Ücretsiz sürümde en fazla 2 kayıt ekleyebilirsin.';

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
  String get imported => 'Aktarıldı';

  @override
  String get importBackup => 'Şifreli Yedeği İçe Aktar';

  @override
  String get importCompleted => 'İçe aktarma tamamlandı';

  @override
  String get importCSV => 'CSV Dosyasından İçe Aktar';

  @override
  String get importData => 'Veriyi İçe Aktar';

  @override
  String get importFailed => 'İçe aktarma başarısız';

  @override
  String get importPin => 'Geri Yükleme PIN’i';

  @override
  String get importText => 'Metin Dosyasından İçe Aktar';

  @override
  String get language => 'Dil';

  @override
  String get limitReached => 'Limit aşıldı';

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
  String get myVaultCleared => 'Kasa temizlendi';

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
  String get pattern => 'Desen';

  @override
  String get patternMismatch => 'Desenler eşleşmedi. Tekrar başla';

  @override
  String get patternSkipped => 'Desen atlandı';

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
  String get rateOnPlayStore => 'Play Store\'da Puanla';

  @override
  String get removeAttachment => 'Dosyayı kaldır';

  @override
  String get save => 'Kaydet';

  @override
  String get savePin => 'PIN Kaydet';

  @override
  String get search => 'Ara';

  @override
  String get secondaryLock => 'İkincil Kilit';

  @override
  String get security => 'Güvenlik';

  @override
  String get securityManifesto => 'Güvenlik Modeli';

  @override
  String get securitySummaryBody => 'Lynra GreyNote, verilerinizi yalnızca cihazınızda saklayan çevrimdışı bir güvenli kasadır.\nUygulama sunucu kullanmaz, sizi takip etmez ve hiçbir veri toplamaz.\nTüm kayıtlarınız güçlü şifreleme ile korunur ve yalnızca siz erişebilirsiniz.\nUygulama arka plana alındığında otomatik olarak kilitlenir ve ekran görüntüsü alınması engellenir.\nKilit açma bilgileri unutulursa veriler geri getirilemez.\nDetaylı teknik bilgi için aşağıdaki Gelişmiş Güvenlik bölümünü inceleyebilirsiniz.';

  @override
  String get securitySummaryTitle => 'Güvenlik Özeti';

  @override
  String get selectLanguage => 'Dil Seç';

  @override
  String get settings => 'Ayarlar';

  @override
  String get setPin => 'PIN Ayarla';

  @override
  String get sort => 'Sırala';

  @override
  String get sortFavorites => 'Favoriler';

  @override
  String get sortUpdated => 'Son güncellenen';

  @override
  String get sortAZ => 'A–Z';

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
  String get viewAttachment => 'Eki görüntüle';

  @override
  String get wrongPattern => 'Yanlış desen. Tekrar dene';

  @override
  String get wrongPin => 'Yanlış PIN';

  @override
  String get textTemplate => 'Metin Şablonu';

  @override
  String get title => 'Başlık';

  @override
  String get txtImportCompleted => 'İçe aktarma tamamlandı.';

  @override
  String get txtImportCompletedWithSkip => 'İçe aktarma tamamlandı. %d desen kaydı atlandı.';

  @override
  String get txtExportCompletedWithSkip => 'Dışa aktarma tamamlandı. Bu dosya şifrelenmemiştir. %d desen kaydı atlandı.';

  @override
  String get txtExportCompleted => 'Dışa aktarma tamamlandı. Bu dosya şifreli değildir.';

  @override
  String get unlock => 'Kilidi Aç';

  @override
  String get unlockContent => 'İçeriğin Kilidini Aç';

  @override
  String get unlockVault => 'Kasayı Aç';

  @override
  String get unlockToSearch => 'Aramak için kilidi aç';

  @override
  String get upgrade => 'Yükselt';

  @override
  String get untitled => 'Başlıksız';

  @override
  String updatedDate(Object date) {
    return 'Güncellendi $date';
  }

  @override
  String get usageGuide => 'Kullanım Rehberi';

  @override
  String get usageGuideText => '• Verilerin yalnızca cihazında saklanır.\n\n•Cihaz değişimi gibi durumlarda verilerini koruyabilmek için periyodik yedek alman önerilir.\n\n• Güvenlik nedeniyle pattern girişleri export dosyalarına dahil edilmez.\n\n• Kasa Kelimesi ekrandaki hassas içerikleri gizler.\n\n• Uygulama arka plana geçtiğinde otomatik olarak kilitlenir.\n\n• Bu uygulama bulut senkronizasyonu veya harici sunucu kullanmaz.\n\n• Import işlemleri için önce uygun template dosyasını indirip kayıtlarını buna uygun oluştur.\n\n• Bir kayıt veya koleksiyonu silmek için uzun bas.';

  @override
  String get username => 'Kullanıcı Adı';

  @override
  String get usernameCopied => 'Kullanıcı adı kopyalandı';

  @override
  String get usernameEmail => 'Kullanıcı Adı / E-posta';
}
