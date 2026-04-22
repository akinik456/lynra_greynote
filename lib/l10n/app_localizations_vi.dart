// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get limitReached => 'Limit reached';

  @override
  String get freeLimitEntries => 'You can add up to 2 entries in the free version.';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get cancel => 'Hủy';

  @override
  String get add => 'Thêm';

  @override
  String get addFirstSecureEntry => 'Nhấn nút + để thêm mục an toàn đầu tiên.';

  @override
  String get addIban => 'Thêm IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'Xác thực để tiếp tục';

  @override
  String get bankDetails => 'Thông tin ngân hàng';

  @override
  String get biometric => 'Sinh trắc học';

  @override
  String get biometricFailed => 'Sinh trắc học thất bại';

  @override
  String get biometricNotAvailable => 'Sinh trắc học không khả dụng';

  @override
  String get biometricSuccess => 'Sinh trắc học thành công';

  @override
  String get biometricWithBackupPin => 'Sinh trắc học - kèm PIN dự phòng';

  @override
  String get collection => 'Bộ sưu tập';

  @override
  String get collectionExample => 'vd: Sao lưu';

  @override
  String get confirmPattern => 'Vẽ lại mẫu để xác nhận';

  @override
  String get confirmPin => 'Xác nhận PIN';

  @override
  String get continueText => 'Tiếp tục';

  @override
  String get created => 'Đã tạo';

  @override
  String get createVaultKey => 'Tạo khóa kho';

  @override
  String get delete => 'Xóa';

  @override
  String get deleteCollection => 'Xóa bộ sưu tập';

  @override
  String deleteCollectionConfirm(Object name) {
    return 'Xóa \"$name\"?\n\nTất cả mục sẽ bị xóa vĩnh viễn.';
  }

  @override
  String get deleteEntry => 'Xóa mục';

  @override
  String deleteEntryConfirm(Object name) {
    return 'Xóa \"$name\"?';
  }

  @override
  String get details => 'Chi tiết';

  @override
  String get drawNewPattern => 'Vẽ mẫu mới';

  @override
  String get drawVaultKey => 'Vẽ khóa kho của bạn';

  @override
  String get editEntry => 'Sửa mục';

  @override
  String get enableVaultWord => 'Bật từ khóa kho';

  @override
  String get enterPin => 'Nhập PIN';

  @override
  String get enterPinHint => 'Nhập PIN 5 chữ số';

  @override
  String get enterVaultWord => 'Nhập từ khóa kho';

  @override
  String get entryDetails => 'Chi tiết mục';

  @override
  String get export => 'Xuất';

  @override
  String get exportComingNext => 'Xuất sắp có';

  @override
  String get exportCompleted => 'Xuất hoàn tất';

  @override
  String get exportData => 'Xuất dữ liệu';

  @override
  String get exportPin => 'PIN sao lưu';

  @override
  String get generatePassword => 'Tạo mật khẩu';

  @override
  String get generatePasswordDescription => 'Tạo mật khẩu mạnh bên dưới. Sao chép sẽ tự điền vào trường mật khẩu.';

  @override
  String get generate => 'Tạo';

  @override
  String get hideSensitiveContent => 'Ẩn nội dung nhạy cảm đến khi mở khóa';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'Đã sao chép IBAN';

  @override
  String get import => 'Nhập';

  @override
  String get importCompleted => 'Nhập hoàn tất';

  @override
  String get importData => 'Nhập dữ liệu';

  @override
  String get importFailed => 'Nhập thất bại';

  @override
  String get importPin => 'PIN khôi phục';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get lynraSecurity => 'Bảo mật Lynra';

  @override
  String get max5Collections => 'Tối đa 5 bộ sưu tập';

  @override
  String get medium => 'Trung bình';

  @override
  String get min5Dots => 'Dùng ít nhất 5 điểm';

  @override
  String get modified => 'Đã sửa';

  @override
  String get myVault => 'Kho của tôi';

  @override
  String get newCollection => 'Bộ sưu tập mới';

  @override
  String get newEntry => 'Mục mới';

  @override
  String get noEntriesYet => 'Chưa có mục';

  @override
  String get none => 'Không có';

  @override
  String get noNoteAdded => 'Chưa có ghi chú';

  @override
  String get noPasswordGenerated => 'Chưa tạo mật khẩu';

  @override
  String get note => 'Ghi chú';

  @override
  String get noteType => 'Ghi chú';

  @override
  String get noUsername => 'Không có tên người dùng';

  @override
  String get onboardingDescription => 'Dữ liệu của bạn chỉ lưu trên thiết bị.\n\nLynraGreyNote không dùng máy chủ, không theo dõi và không thu thập thông tin.\n\nMọi dữ liệu đều được mã hóa và lưu cục bộ.\nChỉ bạn có thể truy cập.\n\nDùng PIN phụ hoặc sinh trắc học để truy cập nhanh và an toàn.\nBật từ khóa kho để tăng thêm riêng tư và ẩn nội dung khi cần.';

  @override
  String get optionalNote => 'Ghi chú tùy chọn';

  @override
  String get password => 'Mật khẩu';

  @override
  String get passwordCopied => 'Đã sao chép mật khẩu';

  @override
  String get patternMismatch => 'Mẫu không khớp. Thử lại';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN phải gồm 6 chữ số';

  @override
  String get pinSaved => 'Đã lưu PIN';

  @override
  String get pinsDoNotMatch => 'PIN không khớp';

  @override
  String get privateByDesign => 'Quyền riêng tư là nền tảng, không phải tính năng';

  @override
  String get save => 'Lưu';

  @override
  String get savePin => 'Lưu PIN';

  @override
  String get secondaryLock => 'Khóa phụ';

  @override
  String get security => 'Bảo mật';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ';

  @override
  String get settings => 'Cài đặt';

  @override
  String get setPin => 'Đặt PIN';

  @override
  String get standard => 'Chuẩn';

  @override
  String get strong => 'Mạnh';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'mục',
      one: 'mục',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'Từ khóa kho';

  @override
  String get weak => 'Yếu';

  @override
  String get wrongPattern => 'Mẫu sai. Thử lại';

  @override
  String get wrongPin => 'PIN sai';

  @override
  String get title => 'Tiêu đề';

  @override
  String get unlock => 'Mở khóa';

  @override
  String get unlockContent => 'Mở nội dung';

  @override
  String get unlockVault => 'Mở kho';

  @override
  String get untitled => 'Không tiêu đề';

  @override
  String updatedDate(Object date) {
    return 'Cập nhật $date';
  }

  @override
  String get username => 'Tên người dùng';

  @override
  String get usernameCopied => 'Đã sao chép tên người dùng';

  @override
  String get usernameEmail => 'Tên người dùng / Email';
}
