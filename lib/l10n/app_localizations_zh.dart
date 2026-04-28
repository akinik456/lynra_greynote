// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get pattern => '图案';

  @override
  String get removeAttachment => '移除文件';

  @override
  String get attachmentRemoved => '附件已删除';

  @override
  String get viewAttachment => '查看附件';

  @override
  String get addAttachment => '添加附件';

  @override
  String get attachmentReady => '添付ファイルの準備完了';

  @override
  String get attachmentTooLarge => '最大2MB';

  @override
  String get search => '搜索';

  @override
  String get unlockToSearch => '解锁后搜索';

  @override
  String get limitReached => '已达到限制';

  @override
  String get freeLimitEntries => '免费版本最多可添加2条记录。';

  @override
  String get upgrade => '升级';

  @override
  String get cancel => '取消';

  @override
  String get add => '添加';

  @override
  String get addFirstSecureEntry => '点击 + 按钮添加您的第一个安全条目。';

  @override
  String get addIban => '添加 IBAN';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => '验证以继续';

  @override
  String get bankDetails => '银行信息';

  @override
  String get biometric => '生物识别';

  @override
  String get biometricFailed => '生物识别失败';

  @override
  String get biometricNotAvailable => '生物识别不可用';

  @override
  String get biometricSuccess => '生物识别成功';

  @override
  String get biometricWithBackupPin => '生物识别 - 带PIN备用';

  @override
  String get collection => '集合';

  @override
  String get collectionExample => '例如：备份';

  @override
  String get confirmPattern => '再次绘制相同图案以确认';

  @override
  String get confirmPin => '确认 PIN';

  @override
  String get continueText => '继续';

  @override
  String get created => '已创建';

  @override
  String get createVaultKey => '创建您的密钥';

  @override
  String get delete => '删除';

  @override
  String get deleteCollection => '删除集合';

  @override
  String deleteCollectionConfirm(Object name) {
    return '删除“$name”？\n\n所有条目将被永久删除。';
  }

  @override
  String get deleteEntry => '删除条目';

  @override
  String deleteEntryConfirm(Object name) {
    return '删除“$name”？';
  }

  @override
  String get details => '详情';

  @override
  String get drawNewPattern => '绘制新图案';

  @override
  String get drawVaultKey => '绘制您的密钥';

  @override
  String get editEntry => '编辑条目';

  @override
  String get enableVaultWord => '启用密语';

  @override
  String get enterPin => '输入 PIN';

  @override
  String get enterPinHint => '输入 5 位 PIN';

  @override
  String get enterVaultWord => '输入您的密语';

  @override
  String get entryDetails => '条目详情';

  @override
  String get export => '导出';

  @override
  String get exportComingNext => '导出即将推出';

  @override
  String get exportCompleted => '导出完成';

  @override
  String get exportData => '导出数据';

  @override
  String get exportPin => '备份 PIN';

  @override
  String get generatePassword => '生成密码';

  @override
  String get generatePasswordDescription => '创建一个强密码。复制后将自动填入密码字段。';

  @override
  String get generate => '生成';

  @override
  String get hideSensitiveContent => '解锁前隐藏敏感内容';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN 已复制';

  @override
  String get import => '导入';

  @override
  String get importCompleted => '导入完成';

  @override
  String get importData => '导入数据';

  @override
  String get importFailed => '导入失败';

  @override
  String get importPin => '恢复 PIN';

  @override
  String get language => '语言';

  @override
  String get lynraSecurity => 'Lynra 安全';

  @override
  String get max5Collections => '最多允许 5 个集合';

  @override
  String get medium => '中等';

  @override
  String get min5Dots => '至少使用 5 个点';

  @override
  String get modified => '已修改';

  @override
  String get myVault => '我的保险库';

  @override
  String get newCollection => '新建集合';

  @override
  String get newEntry => '新建条目';

  @override
  String get noEntriesYet => '暂无条目';

  @override
  String get none => '无';

  @override
  String get noNoteAdded => '未添加备注';

  @override
  String get noPasswordGenerated => '尚未生成密码';

  @override
  String get note => '备注';

  @override
  String get noteType => '备注';

  @override
  String get noUsername => '无用户名';

  @override
  String get onboardingDescription => '您的数据仅保存在设备上。\n\nLynraGreyNote 不使用服务器，不跟踪您，也不收集任何信息。\n\n所有内容均已加密并本地存储。\n仅您可访问。\n\n可使用辅助 PIN 或生物识别实现快速安全访问。\n启用密语可增加隐私保护并在需要时隐藏内容。';

  @override
  String get optionalNote => '可选备注';

  @override
  String get password => '密码';

  @override
  String get passwordCopied => '密码已复制';

  @override
  String get patternMismatch => '图案不匹配，请重试';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN 必须为 6 位';

  @override
  String get pinSaved => 'PIN 已保存';

  @override
  String get pinsDoNotMatch => 'PIN 不匹配';

  @override
  String get privateByDesign => '隐私是基础，而非功能';

  @override
  String get save => '保存';

  @override
  String get savePin => '保存 PIN';

  @override
  String get secondaryLock => '辅助锁';

  @override
  String get security => '安全';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get settings => '设置';

  @override
  String get setPin => '设置 PIN';

  @override
  String get standard => '标准';

  @override
  String get strong => '强';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '项',
      one: '项',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => '密语';

  @override
  String get weak => '弱';

  @override
  String get wrongPattern => '图案错误，请重试';

  @override
  String get wrongPin => 'PIN 错误';

  @override
  String get title => '标题';

  @override
  String get unlock => '解锁';

  @override
  String get unlockContent => '解锁内容';

  @override
  String get unlockVault => '解锁保险库';

  @override
  String get untitled => '未命名';

  @override
  String updatedDate(Object date) {
    return '更新于 $date';
  }

  @override
  String get username => '用户名';

  @override
  String get usernameCopied => '用户名已复制';

  @override
  String get usernameEmail => '用户名 / 邮箱';
}
