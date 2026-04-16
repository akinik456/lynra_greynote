// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get confirmPattern => 'Onaylamak için aynı deseni tekrar çiz';

  @override
  String get continueText => 'Devam Et';

  @override
  String get createVaultKey => 'Kasa Anahtarı Oluştur';

  @override
  String get drawNewPattern => 'Yeni bir desen çiz';

  @override
  String get drawVaultKey => 'Kasa anahtarını çiz';

  @override
  String get lynraSecurity => 'Lynra Güvenlik';

  @override
  String get min4Dots => 'En az 4 nokta kullan';

  @override
  String get onboardingDescription => 'Verileriniz cihazınızda kalır.\n\nLynraGreyNote sunucu kullanmaz, sizi takip etmez ve hiçbir veri toplamaz.\n\nKaydettiğiniz her şey şifrelenir ve cihazda saklanır.\nSadece siz erişebilirsiniz.\n\nHızlı ve güvenli erişim için PIN veya Biyometri kullanabilirsiniz.\nEkstra gizlilik için Kasa Anahtarı özelliğini açabilirsiniz.';

  @override
  String get patternMismatch => 'Desenler eşleşmedi. Tekrar başla';

  @override
  String get privateByDesign => 'Gizlilik Önceliğimiz';

  @override
  String get wrongPattern => 'Yanlış desen. Tekrar dene';

  @override
  String get unlock => 'Kilidi Aç';

  @override
  String get unlockVault => 'Kasayı Aç';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get settings => 'Ayarlar';

  @override
  String get security => 'Güvenlik';

  @override
  String get vaultWord => 'Kasa Kelimesi';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get editEntry => 'Kaydı Düzenle';

  @override
  String get newEntry => 'Yeni Kayıt';
}
