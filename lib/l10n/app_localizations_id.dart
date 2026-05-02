// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get pattern => 'Pola';

  @override
  String get removeAttachment => 'Hapus file';

  @override
  String get attachmentRemoved => 'Lampiran dihapus';

  @override
  String get viewAttachment => 'Lihat lampiran';

  @override
  String get addAttachment => 'Tambah lampiran';

  @override
  String get attachmentReady => 'Lampiran siap';

  @override
  String get attachmentTooLarge => 'Maksimal 2 MB';

  @override
  String get search => 'Cari';

  @override
  String get unlockToSearch => 'Buka kunci untuk mencari';

  @override
  String get limitReached => 'Batas tercapai';

  @override
  String get freeLimitEntries => 'Anda dapat menambahkan hingga 2 entri di versi gratis.';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get cancel => 'Batal';

  @override
  String get add => 'Tambah';

  @override
  String get addFirstSecureEntry => 'Ketuk tombol + untuk menambahkan entri aman pertama Anda.';

  @override
  String get addIban => 'Tambah IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Autentikasi untuk melanjutkan';

  @override
  String get bankDetails => 'Detail Bank';

  @override
  String get biometric => 'Biometrik';

  @override
  String get biometricFailed => 'Biometrik gagal';

  @override
  String get biometricNotAvailable => 'Biometrik tidak tersedia';

  @override
  String get biometricSuccess => 'Biometrik berhasil';

  @override
  String get biometricWithBackupPin => 'Biometrik - dengan PIN cadangan';

  @override
  String get collection => 'Koleksi';

  @override
  String get collectionExample => 'mis. Cadangan';

  @override
  String get confirmPattern => 'Gambar ulang pola untuk konfirmasi';

  @override
  String get confirmPin => 'Konfirmasi PIN';

  @override
  String get continueText => 'Lanjutkan';

  @override
  String get created => 'Dibuat';

  @override
  String get createVaultKey => 'Buat Kunci Vault Anda';

  @override
  String get delete => 'Hapus';

  @override
  String get deleteCollection => 'Hapus Koleksi';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'Hapus \"$name\"?\n\nSemua entri akan dihapus permanen.';
  }

  @override
  String get deleteEntry => 'Hapus entri';

  @override
  String deleteEntryConfirm(Object name) {
    return 'Hapus \"$name\"?';
  }

  @override
  String get details => 'Detail';

  @override
  String get drawNewPattern => 'Gambar pola baru';

  @override
  String get drawVaultKey => 'Gambar kunci vault Anda';

  @override
  String get editEntry => 'Edit Entri';

  @override
  String get enableVaultWord => 'Aktifkan Kata Vault';

  @override
  String get enterPin => 'Masukkan PIN';

  @override
  String get enterPinHint => 'Masukkan PIN 5 digit';

  @override
  String get enterVaultWord => 'Masukkan kata vault Anda';

  @override
  String get entryDetails => 'Detail Entri';

  @override
  String get export => 'Ekspor';

  @override
  String get exportComingNext => 'Ekspor segera hadir';

  @override
  String get exportCompleted => 'Ekspor selesai';

  @override
  String get exportData => 'Ekspor Data';

  @override
  String get exportPin => 'PIN Cadangan';

  @override
  String get generatePassword => 'Buat Kata Sandi';

  @override
  String get generatePasswordDescription => 'Buat kata sandi kuat di bawah. Menyalinnya juga akan mengisi kolom kata sandi.';

  @override
  String get generate => 'Buat';

  @override
  String get hideSensitiveContent => 'Sembunyikan konten sensitif hingga dibuka';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN disalin';

  @override
  String get import => 'Impor';

  @override
  String get importCompleted => 'Impor selesai';

  @override
  String get importData => 'Impor Data';

  @override
  String get importFailed => 'Impor gagal';

  @override
  String get importPin => 'PIN Pemulihan';

  @override
  String get language => 'Bahasa';

  @override
  String get lynraSecurity => 'Keamanan Lynra';

  @override
  String get max5Collections => 'Maksimal 5 koleksi';

  @override
  String get medium => 'Sedang';

  @override
  String get min5Dots => 'Gunakan minimal 5 titik';

  @override
  String get modified => 'Diubah';

  @override
  String get myVault => 'Vault Saya';

  @override
  String get newCollection => 'Koleksi Baru';

  @override
  String get newEntry => 'Entri Baru';

  @override
  String get noEntriesYet => 'Belum ada entri';

  @override
  String get none => 'Tidak ada';

  @override
  String get noNoteAdded => 'Tidak ada catatan';

  @override
  String get noPasswordGenerated => 'Belum ada kata sandi';

  @override
  String get note => 'Catatan';

  @override
  String get noteType => 'Catatan';

  @override
  String get noUsername => 'Tidak ada username';

  @override
  String get onboardingDescription => 'Data Anda tetap di perangkat Anda.\n\nLynraGreyNote tidak menggunakan server, tidak melacak Anda, dan tidak mengumpulkan informasi apa pun.\n\nSemua yang Anda simpan dienkripsi dan disimpan secara lokal.\nHanya Anda yang dapat mengaksesnya.\n\nGunakan PIN Sekunder atau Biometrik untuk akses cepat dan aman.\nAktifkan Kata Vault untuk lapisan privasi tambahan dan menyembunyikan konten saat diperlukan.';

  @override
  String get optionalNote => 'Catatan opsional';

  @override
  String get password => 'Kata Sandi';

  @override
  String get passwordCopied => 'Kata sandi disalin';

  @override
  String get patternMismatch => 'Pola tidak cocok. Ulangi';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN harus 6 digit';

  @override
  String get pinSaved => 'PIN disimpan';

  @override
  String get pinsDoNotMatch => 'PIN tidak cocok';

  @override
  String get privateByDesign => 'Privasi adalah dasar, bukan fitur';

  @override
  String get save => 'Simpan';

  @override
  String get savePin => 'Simpan PIN';

  @override
  String get secondaryLock => 'Kunci Sekunder';

  @override
  String get security => 'Keamanan';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get settings => 'Pengaturan';

  @override
  String get setPin => 'Atur PIN';

  @override
  String get standard => 'Standar';

  @override
  String get strong => 'Kuat';

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
  String get vaultWord => 'Kata Vault';

  @override
  String get weak => 'Lemah';

  @override
  String get wrongPattern => 'Pola salah. Coba lagi';

  @override
  String get wrongPin => 'PIN salah';

  @override
  String get title => 'Judul';

  @override
  String get unlock => 'Buka';

  @override
  String get unlockContent => 'Buka Konten';

  @override
  String get unlockVault => 'Buka Vault';

  @override
  String get untitled => 'Tanpa Judul';

  @override
  String updatedDate(Object date) {
    return 'Diperbarui $date';
  }

  @override
  String get username => 'Username';

  @override
  String get usernameCopied => 'Username disalin';

  @override
  String get usernameEmail => 'Username / Email';

  @override
  String get securityManifesto => 'Model Keamanan';

  @override
  String get securitySummaryTitle => 'Ringkasan Keamanan';

  @override
  String get advancedSecurityTitle => 'Keamanan Lanjutan';

  @override
  String get securitySummaryBody => 'Lynra GreyNote adalah brankas aman offline yang menyimpan data Anda hanya di perangkat Anda.\nAplikasi ini tidak menggunakan server, tidak melacak Anda, dan tidak mengumpulkan data apa pun.\nSemua catatan Anda dilindungi dengan enkripsi kuat dan hanya dapat diakses oleh Anda.\nSaat aplikasi masuk ke latar belakang, aplikasi akan terkunci secara otomatis dan tangkapan layar dicegah.\nJika informasi pembukaan kunci dilupakan, data tidak dapat dipulihkan.\nUntuk informasi teknis lebih lanjut, silakan lihat bagian Keamanan Lanjutan di bawah ini.';

  @override
  String get advancedSecurityBody => 'Lynra GreyNote dirancang sesuai dengan prinsip kriptografi modern.\n\nPerlindungan Data:\nIsi catatan dienkripsi menggunakan algoritma AES-256-GCM.\nDatabase disimpan sepenuhnya terenkripsi menggunakan SQLCipher.\n\nManajemen Kunci:\nKunci utama (Master Key) diturunkan dari kunci pengguna menggunakan algoritma PBKDF2-HMAC-SHA256.\nKunci ini tidak pernah disimpan dalam bentuk teks biasa dan hanya digunakan selama sesi aktif.\n\nPemisahan Kunci (Key Separation):\nAkses database dan enkripsi data menggunakan kunci yang berbeda.\n\nLapisan Keamanan Tambahan:\nSaat Vault Word diaktifkan, data dilindungi oleh lapisan kedua.\nKunci ini tidak disimpan di perangkat dan hanya diketahui oleh pengguna.\n\nKeamanan Sesi:\nSaat aplikasi masuk ke latar belakang, akses akan terkunci secara otomatis.\nKunci enkripsi hanya disimpan di memori selama pemrosesan.\n\nKeamanan Layar:\nTangkapan layar dan perekaman layar diblokir pada tingkat sistem.\n\nCadangan:\nSaat diekspor, data dibuat sebagai blok terenkripsi (encrypted blob) dan hanya dapat dipulihkan dengan informasi yang benar.\n\nLynra tidak dapat mengakses, membaca, atau memulihkan data pengguna.\n\nSeluruh model keamanan didasarkan pada kontrol penuh pengguna atas data.';
}
