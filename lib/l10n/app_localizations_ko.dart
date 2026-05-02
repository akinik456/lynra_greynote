// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get pattern => '패턴';

  @override
  String get removeAttachment => '파일 제거';

  @override
  String get attachmentRemoved => '첨부 파일이 삭제되었습니다';

  @override
  String get viewAttachment => '첨부 파일 보기';

  @override
  String get addAttachment => '첨부 파일 추가';

  @override
  String get attachmentReady => '첨부 파일 준비됨';

  @override
  String get attachmentTooLarge => '최대 2MB';

  @override
  String get search => '검색';

  @override
  String get unlockToSearch => '검색하려면 잠금 해제';

  @override
  String get limitReached => '제한 도달';

  @override
  String get freeLimitEntries => '무료 버전에서는 최대 2개의 항목을 추가할 수 있습니다.';

  @override
  String get upgrade => '업그레이드';

  @override
  String get cancel => '취소';

  @override
  String get add => '추가';

  @override
  String get addFirstSecureEntry => '+ 버튼을 눌러 첫 번째 보안 항목을 추가하세요.';

  @override
  String get addIban => 'IBAN 추가';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => '계속하려면 인증하세요';

  @override
  String get bankDetails => '은행 정보';

  @override
  String get biometric => '생체 인증';

  @override
  String get biometricFailed => '생체 인증 실패';

  @override
  String get biometricNotAvailable => '생체 인증 사용 불가';

  @override
  String get biometricSuccess => '생체 인증 성공';

  @override
  String get biometricWithBackupPin => '생체인증 - PIN 백업 포함';

  @override
  String get collection => '컬렉션';

  @override
  String get collectionExample => '예: 백업';

  @override
  String get confirmPattern => '확인을 위해 동일한 패턴을 다시 그리세요';

  @override
  String get confirmPin => 'PIN 확인';

  @override
  String get continueText => '계속';

  @override
  String get created => '생성됨';

  @override
  String get createVaultKey => '볼트 키 생성';

  @override
  String get delete => '삭제';

  @override
  String get deleteCollection => '컬렉션 삭제';

  @override
  String deleteCollectionConfirm(Object name) {
    return '\"$name\"을(를) 삭제하시겠습니까?\n\n모든 항목이 영구적으로 삭제됩니다.';
  }

  @override
  String get deleteEntry => '항목 삭제';

  @override
  String deleteEntryConfirm(Object name) {
    return '\"$name\"을(를) 삭제하시겠습니까?';
  }

  @override
  String get details => '상세 정보';

  @override
  String get drawNewPattern => '새 패턴 그리기';

  @override
  String get drawVaultKey => '볼트 키를 그리세요';

  @override
  String get editEntry => '항목 수정';

  @override
  String get enableVaultWord => '볼트 단어 활성화';

  @override
  String get enterPin => 'PIN 입력';

  @override
  String get enterPinHint => '5자리 PIN 입력';

  @override
  String get enterVaultWord => '볼트 단어 입력';

  @override
  String get entryDetails => '항목 상세';

  @override
  String get export => '내보내기';

  @override
  String get exportComingNext => '내보내기 기능 준비 중';

  @override
  String get exportCompleted => '내보내기 완료';

  @override
  String get exportData => '데이터 내보내기';

  @override
  String get exportPin => '백업 PIN';

  @override
  String get generatePassword => '비밀번호 생성';

  @override
  String get generatePasswordDescription => '아래에서 강력한 비밀번호를 생성하세요. 복사하면 비밀번호 필드에도 자동 입력됩니다.';

  @override
  String get generate => '생성';

  @override
  String get hideSensitiveContent => '잠금 해제 전까지 민감한 내용 숨기기';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN 복사됨';

  @override
  String get import => '가져오기';

  @override
  String get importCompleted => '가져오기 완료';

  @override
  String get importData => '데이터 가져오기';

  @override
  String get importFailed => '가져오기 실패';

  @override
  String get importPin => '복원 PIN';

  @override
  String get language => '언어';

  @override
  String get lynraSecurity => 'Lynra 보안';

  @override
  String get max5Collections => '최대 5개의 컬렉션만 허용됩니다';

  @override
  String get medium => '보통';

  @override
  String get min5Dots => '최소 5개의 점을 사용하세요';

  @override
  String get modified => '수정됨';

  @override
  String get myVault => '내 볼트';

  @override
  String get newCollection => '새 컬렉션';

  @override
  String get newEntry => '새 항목';

  @override
  String get noEntriesYet => '아직 항목이 없습니다';

  @override
  String get none => '없음';

  @override
  String get noNoteAdded => '추가된 노트 없음';

  @override
  String get noPasswordGenerated => '아직 생성된 비밀번호 없음';

  @override
  String get note => '노트';

  @override
  String get noteType => '노트';

  @override
  String get noUsername => '사용자 이름 없음';

  @override
  String get onboardingDescription => '데이터는 기기에만 저장됩니다.\n\nLynraGreyNote는 서버를 사용하지 않으며, 사용자를 추적하거나 정보를 수집하지 않습니다.\n\n저장된 모든 데이터는 암호화되어 로컬에 보관됩니다.\n오직 본인만 접근할 수 있습니다.\n\n빠르고 안전한 접근을 위해 보조 PIN 또는 생체 인증을 사용하세요.\n볼트 단어를 활성화하면 추가적인 프라이버시 보호와 필요 시 콘텐츠 숨김이 가능합니다.';

  @override
  String get optionalNote => '선택적 노트';

  @override
  String get password => '비밀번호';

  @override
  String get passwordCopied => '비밀번호 복사됨';

  @override
  String get patternMismatch => '패턴이 일치하지 않습니다. 다시 시도하세요';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN은 6자리여야 합니다';

  @override
  String get pinSaved => 'PIN 저장됨';

  @override
  String get pinsDoNotMatch => 'PIN이 일치하지 않습니다';

  @override
  String get privateByDesign => '프라이버시는 기능이 아닌 기본입니다';

  @override
  String get save => '저장';

  @override
  String get savePin => 'PIN 저장';

  @override
  String get secondaryLock => '보조 잠금';

  @override
  String get security => '보안';

  @override
  String get selectLanguage => '언어 선택';

  @override
  String get settings => '설정';

  @override
  String get setPin => 'PIN 설정';

  @override
  String get standard => '표준';

  @override
  String get strong => '강함';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '항목들',
      one: '항목',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => '볼트 단어';

  @override
  String get weak => '약함';

  @override
  String get wrongPattern => '잘못된 패턴입니다. 다시 시도하세요';

  @override
  String get wrongPin => '잘못된 PIN';

  @override
  String get title => '제목';

  @override
  String get unlock => '잠금 해제';

  @override
  String get unlockContent => '콘텐츠 잠금 해제';

  @override
  String get unlockVault => '볼트 잠금 해제';

  @override
  String get untitled => '제목 없음';

  @override
  String updatedDate(Object date) {
    return '$date 업데이트됨';
  }

  @override
  String get username => '사용자 이름';

  @override
  String get usernameCopied => '사용자 이름 복사됨';

  @override
  String get usernameEmail => '사용자 이름 / 이메일';

  @override
  String get securityManifesto => '보안 모델';

  @override
  String get securitySummaryTitle => '보안 요약';

  @override
  String get advancedSecurityTitle => '고급 보안';

  @override
  String get securitySummaryBody => 'Lynra GreyNote는 데이터를 오직 기기 내에만 저장하는 오프라인 보안 금고입니다.\n이 애플리케이션은 서버를 사용하지 않으며, 사용자를 추적하거나 데이터를 수집하지 않습니다.\n모든 항목은 강력한 암호화로 보호되며 오직 사용자만 접근할 수 있습니다.\n앱이 백그라운드로 전환되면 자동으로 잠기며 화면 캡처가 차단됩니다.\n잠금 해제 정보를 잊어버리면 데이터를 복구할 수 없습니다.\n자세한 기술 정보는 아래 고급 보안 섹션을 확인하십시오.';

  @override
  String get advancedSecurityBody => 'Lynra GreyNote는 현대 암호화 원칙에 따라 설계되었습니다.\n\n데이터 보호:\n항목 내용은 AES-256-GCM 알고리즘으로 암호화됩니다.\n데이터베이스는 SQLCipher를 사용하여 완전히 암호화된 상태로 저장됩니다.\n\n키 관리:\n마스터 키는 PBKDF2-HMAC-SHA256 알고리즘을 사용하여 사용자 키로부터 파생됩니다.\n이 키는 평문으로 저장되지 않으며 활성 세션 동안에만 사용됩니다.\n\n키 분리 (Key Separation):\n데이터베이스 접근과 데이터 암호화는 서로 다른 키를 사용합니다.\n\n추가 보안 계층:\nVault Word가 활성화되면 데이터는 두 번째 계층으로 보호됩니다.\n이 키는 기기에 저장되지 않으며 사용자만 알고 있습니다.\n\n세션 보안:\n앱이 백그라운드로 전환되면 접근이 자동으로 잠깁니다.\n암호화 키는 처리 중에만 메모리에 유지됩니다.\n\n화면 보안:\n스크린샷 및 화면 녹화는 시스템 수준에서 차단됩니다.\n\n백업:\n내보내기 시 데이터는 암호화된 블록(encrypted blob)으로 생성되며 올바른 정보로만 복원할 수 있습니다.\n\nLynra는 사용자 데이터에 접근하거나 읽거나 복구할 수 없습니다.\n\n전체 보안 모델은 데이터가 사용자에 의해 완전히 제어된다는 원칙에 기반합니다.';
}
