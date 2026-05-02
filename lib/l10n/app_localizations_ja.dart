// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get pattern => 'パターン';

  @override
  String get removeAttachment => 'ファイルを削除';

  @override
  String get attachmentRemoved => '添付ファイルが削除されました';

  @override
  String get viewAttachment => '添付ファイルを表示';

  @override
  String get addAttachment => '添付ファイルを追加';

  @override
  String get attachmentReady => '添付ファイルの準備完了';

  @override
  String get attachmentTooLarge => '最大2MB';

  @override
  String get search => '検索';

  @override
  String get unlockToSearch => '検索するにはロック解除';

  @override
  String get limitReached => '上限に達しました';

  @override
  String get freeLimitEntries => '無料版では最大2件まで追加できます。';

  @override
  String get upgrade => 'アップグレード';

  @override
  String get cancel => 'キャンセル';

  @override
  String get add => '追加';

  @override
  String get addFirstSecureEntry => '+ ボタンをタップして最初のセキュアエントリを追加してください。';

  @override
  String get addIban => 'IBANを追加';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => '続行するには認証してください';

  @override
  String get bankDetails => '銀行情報';

  @override
  String get biometric => '生体認証';

  @override
  String get biometricFailed => '生体認証に失敗しました';

  @override
  String get biometricNotAvailable => '生体認証は利用できません';

  @override
  String get biometricSuccess => '生体認証に成功しました';

  @override
  String get biometricWithBackupPin => '生体認証 - PINバックアップ付き';

  @override
  String get collection => 'コレクション';

  @override
  String get collectionExample => '例：バックアップ';

  @override
  String get confirmPattern => '確認のため同じパターンをもう一度描いてください';

  @override
  String get confirmPin => 'PINを確認';

  @override
  String get continueText => '続行';

  @override
  String get created => '作成日';

  @override
  String get createVaultKey => 'ボルトキーを作成';

  @override
  String get delete => '削除';

  @override
  String get deleteCollection => 'コレクションを削除';

  @override
  String deleteCollectionConfirm(Object name) {
    return '「$name」を削除しますか？\n\nすべてのエントリは完全に削除されます。';
  }

  @override
  String get deleteEntry => 'エントリを削除';

  @override
  String deleteEntryConfirm(Object name) {
    return '「$name」を削除しますか？';
  }

  @override
  String get details => '詳細';

  @override
  String get drawNewPattern => '新しいパターンを描く';

  @override
  String get drawVaultKey => 'ボルトキーを描いてください';

  @override
  String get editEntry => 'エントリを編集';

  @override
  String get enableVaultWord => 'ボルトワードを有効化';

  @override
  String get enterPin => 'PINを入力';

  @override
  String get enterPinHint => '5桁のPINを入力';

  @override
  String get enterVaultWord => 'ボルトワードを入力';

  @override
  String get entryDetails => 'エントリ詳細';

  @override
  String get export => 'エクスポート';

  @override
  String get exportComingNext => 'エクスポート機能は近日公開';

  @override
  String get exportCompleted => 'エクスポート完了';

  @override
  String get exportData => 'データをエクスポート';

  @override
  String get exportPin => 'バックアップPIN';

  @override
  String get generatePassword => 'パスワード生成';

  @override
  String get generatePasswordDescription => '強力なパスワードを作成してください。コピーするとパスワード欄にも入力されます。';

  @override
  String get generate => '生成';

  @override
  String get hideSensitiveContent => 'ロック解除まで機密内容を非表示';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBANをコピーしました';

  @override
  String get import => 'インポート';

  @override
  String get importCompleted => 'インポート完了';

  @override
  String get importData => 'データをインポート';

  @override
  String get importFailed => 'インポートに失敗しました';

  @override
  String get importPin => '復元PIN';

  @override
  String get language => '言語';

  @override
  String get lynraSecurity => 'Lynraセキュリティ';

  @override
  String get max5Collections => '最大5つのコレクションまで';

  @override
  String get medium => '中';

  @override
  String get min5Dots => '少なくとも5つのポイントを使用してください';

  @override
  String get modified => '更新日';

  @override
  String get myVault => 'マイボルト';

  @override
  String get newCollection => '新しいコレクション';

  @override
  String get newEntry => '新しいエントリ';

  @override
  String get noEntriesYet => 'まだエントリはありません';

  @override
  String get none => 'なし';

  @override
  String get noNoteAdded => 'ノートが追加されていません';

  @override
  String get noPasswordGenerated => 'まだパスワードが生成されていません';

  @override
  String get note => 'ノート';

  @override
  String get noteType => 'ノート';

  @override
  String get noUsername => 'ユーザー名なし';

  @override
  String get onboardingDescription => 'データはデバイス内にのみ保存されます。\n\nLynraGreyNoteはサーバーを使用せず、追跡や情報収集を行いません。\n\n保存されたすべてのデータは暗号化され、ローカルに保管されます。\nアクセスできるのはあなただけです。\n\n素早く安全にアクセスするためにセカンダリPINまたは生体認証を使用してください。\nボルトワードを有効にすると、追加のプライバシー保護と必要に応じたコンテンツの非表示が可能になります。';

  @override
  String get optionalNote => '任意のノート';

  @override
  String get password => 'パスワード';

  @override
  String get passwordCopied => 'パスワードをコピーしました';

  @override
  String get patternMismatch => 'パターンが一致しません。もう一度やり直してください';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PINは6桁である必要があります';

  @override
  String get pinSaved => 'PINを保存しました';

  @override
  String get pinsDoNotMatch => 'PINが一致しません';

  @override
  String get privateByDesign => 'プライバシーは機能ではなく基本です';

  @override
  String get save => '保存';

  @override
  String get savePin => 'PINを保存';

  @override
  String get secondaryLock => 'セカンダリロック';

  @override
  String get security => 'セキュリティ';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get settings => '設定';

  @override
  String get setPin => 'PINを設定';

  @override
  String get standard => '標準';

  @override
  String get strong => '強い';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '項目',
      one: '項目',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'ボルトワード';

  @override
  String get weak => '弱い';

  @override
  String get wrongPattern => '誤ったパターンです。もう一度お試しください';

  @override
  String get wrongPin => '誤ったPIN';

  @override
  String get title => 'タイトル';

  @override
  String get unlock => 'ロック解除';

  @override
  String get unlockContent => 'コンテンツをロック解除';

  @override
  String get unlockVault => 'ボルトをロック解除';

  @override
  String get untitled => '無題';

  @override
  String updatedDate(Object date) {
    return '$dateに更新';
  }

  @override
  String get username => 'ユーザー名';

  @override
  String get usernameCopied => 'ユーザー名をコピーしました';

  @override
  String get usernameEmail => 'ユーザー名 / メール';

  @override
  String get securityManifesto => 'セキュリティモデル';

  @override
  String get securitySummaryTitle => 'セキュリティ概要';

  @override
  String get advancedSecurityTitle => '高度なセキュリティ';

  @override
  String get securitySummaryBody => 'Lynra GreyNoteは、データをデバイス内のみに保存するオフラインのセキュアボルトです。\nこのアプリはサーバーを使用せず、ユーザーを追跡せず、データを収集しません。\nすべての記録は強力な暗号化で保護され、ユーザーのみがアクセスできます。\nアプリがバックグラウンドに移行すると自動的にロックされ、スクリーンショットが防止されます。\nロック解除情報を忘れた場合、データは復元できません。\n詳細な技術情報については、以下の高度なセキュリティセクションをご覧ください。';

  @override
  String get advancedSecurityBody => 'Lynra GreyNoteは最新の暗号化原則に基づいて設計されています。\n\nデータ保護:\n記録の内容はAES-256-GCMアルゴリズムで暗号化されます。\nデータベースはSQLCipherを使用して完全に暗号化された状態で保存されます。\n\nキー管理:\nマスターキーはPBKDF2-HMAC-SHA256アルゴリズムを使用してユーザーキーから導出されます。\nこのキーは平文で保存されることはなく、アクティブセッション中のみ使用されます。\n\nキー分離 (Key Separation):\nデータベースアクセスとデータ暗号化は異なるキーを使用します。\n\n追加のセキュリティ層:\nVault Wordが有効になると、データは第2層で保護されます。\nこのキーはデバイスに保存されず、ユーザーのみが知っています。\n\nセッションセキュリティ:\nアプリがバックグラウンドに移行するとアクセスは自動的にロックされます。\n暗号化キーは処理中のみメモリに保持されます。\n\n画面セキュリティ:\nスクリーンショットおよび画面録画はシステムレベルでブロックされます。\n\nバックアップ:\nエクスポート時、データは暗号化ブロック(encrypted blob)として作成され、正しい情報でのみ復元できます。\n\nLynraはユーザーデータにアクセス、読み取り、または復元することはできません。\n\nすべてのセキュリティモデルはデータがユーザーによって完全に制御されることに基づいています。';
}
