// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get removeAttachment => 'फ़ाइल हटाएं';

  @override
  String get attachmentRemoved => 'संलग्नक हटाया गया';

  @override
  String get viewAttachment => 'संलग्नक देखें';

  @override
  String get addAttachment => 'संलग्नक जोड़ें';

  @override
  String get attachmentReady => 'संलग्नक तैयार है';

  @override
  String get attachmentTooLarge => 'अधिकतम 2 MB';

  @override
  String get search => 'खोजें';

  @override
  String get unlockToSearch => 'खोजने के लिए अनलॉक करें';

  @override
  String get limitReached => 'सीमा पूरी हो गई';

  @override
  String get freeLimitEntries => 'आप मुफ्त संस्करण में अधिकतम 2 प्रविष्टियाँ जोड़ सकते हैं।';

  @override
  String get upgrade => 'अपग्रेड करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get add => 'जोड़ें';

  @override
  String get addFirstSecureEntry => 'अपनी पहली सुरक्षित एंट्री जोड़ने के लिए + बटन दबाएँ।';

  @override
  String get addIban => 'IBAN जोड़ें';

  @override
  String get appTitle => 'LynraGreyNote';

  @override
  String get authenticateToContinue => 'जारी रखने के लिए सत्यापित करें';

  @override
  String get bankDetails => 'बैंक विवरण';

  @override
  String get biometric => 'बायोमेट्रिक';

  @override
  String get biometricFailed => 'बायोमेट्रिक विफल';

  @override
  String get biometricNotAvailable => 'बायोमेट्रिक उपलब्ध नहीं';

  @override
  String get biometricSuccess => 'बायोमेट्रिक सफल';

  @override
  String get biometricWithBackupPin => 'बायोमेट्रिक - PIN बैकअप के साथ';

  @override
  String get collection => 'संग्रह';

  @override
  String get collectionExample => 'जैसे बैकअप';

  @override
  String get confirmPattern => 'पुष्टि के लिए वही पैटर्न फिर से बनाएं';

  @override
  String get confirmPin => 'PIN की पुष्टि करें';

  @override
  String get continueText => 'जारी रखें';

  @override
  String get created => 'बनाया गया';

  @override
  String get createVaultKey => 'अपनी वॉल्ट कुंजी बनाएं';

  @override
  String get delete => 'हटाएँ';

  @override
  String get deleteCollection => 'संग्रह हटाएँ';

  @override
  String deleteCollectionConfirm(Object name) {
    return '\"$name\" हटाएँ?\n\nसभी एंट्री स्थायी रूप से हट जाएंगी।';
  }

  @override
  String get deleteEntry => 'एंट्री हटाएँ';

  @override
  String deleteEntryConfirm(Object name) {
    return '\"$name\" हटाएँ?';
  }

  @override
  String get details => 'विवरण';

  @override
  String get drawNewPattern => 'नया पैटर्न बनाएं';

  @override
  String get drawVaultKey => 'अपनी वॉल्ट कुंजी बनाएं';

  @override
  String get editEntry => 'एंट्री संपादित करें';

  @override
  String get enableVaultWord => 'वॉल्ट शब्द सक्षम करें';

  @override
  String get enterPin => 'PIN दर्ज करें';

  @override
  String get enterPinHint => '5-अंकीय PIN दर्ज करें';

  @override
  String get enterVaultWord => 'अपना वॉल्ट शब्द दर्ज करें';

  @override
  String get entryDetails => 'एंट्री विवरण';

  @override
  String get export => 'निर्यात';

  @override
  String get exportComingNext => 'निर्यात जल्द आ रहा है';

  @override
  String get exportCompleted => 'निर्यात पूरा हुआ';

  @override
  String get exportData => 'डेटा निर्यात करें';

  @override
  String get exportPin => 'बैकअप PIN';

  @override
  String get generatePassword => 'पासवर्ड बनाएँ';

  @override
  String get generatePasswordDescription => 'नीचे एक मजबूत पासवर्ड बनाएँ। कॉपी करने पर यह पासवर्ड फ़ील्ड में भर जाएगा।';

  @override
  String get generate => 'बनाएँ';

  @override
  String get hideSensitiveContent => 'अनलॉक होने तक संवेदनशील सामग्री छिपाएँ';

  @override
  String get iban => 'IBAN';

  @override
  String get ibanCopied => 'IBAN कॉपी हुआ';

  @override
  String get import => 'आयात';

  @override
  String get importCompleted => 'आयात पूरा हुआ';

  @override
  String get importData => 'डेटा आयात करें';

  @override
  String get importFailed => 'आयात विफल';

  @override
  String get importPin => 'रीस्टोर PIN';

  @override
  String get language => 'भाषा';

  @override
  String get lynraSecurity => 'Lynra सुरक्षा';

  @override
  String get max5Collections => 'अधिकतम 5 संग्रह की अनुमति है';

  @override
  String get medium => 'मध्यम';

  @override
  String get min5Dots => 'कम से कम 5 बिंदु उपयोग करें';

  @override
  String get modified => 'संशोधित';

  @override
  String get myVault => 'मेरा वॉल्ट';

  @override
  String get newCollection => 'नया संग्रह';

  @override
  String get newEntry => 'नई एंट्री';

  @override
  String get noEntriesYet => 'अभी कोई एंट्री नहीं';

  @override
  String get none => 'कोई नहीं';

  @override
  String get noNoteAdded => 'कोई नोट नहीं जोड़ा गया';

  @override
  String get noPasswordGenerated => 'अभी तक कोई पासवर्ड नहीं बनाया गया';

  @override
  String get note => 'नोट';

  @override
  String get noteType => 'नोट';

  @override
  String get noUsername => 'कोई उपयोगकर्ता नाम नहीं';

  @override
  String get onboardingDescription => 'आपका डेटा आपके डिवाइस पर ही रहता है.\n\nLynraGreyNote सर्वर का उपयोग नहीं करता, आपको ट्रैक नहीं करता, और कोई जानकारी एकत्र नहीं करता.\n\nआपका सारा डेटा एन्क्रिप्ट होकर लोकली सुरक्षित रहता है.\nकेवल आप ही इसे एक्सेस कर सकते हैं.\n\nतेज़ और सुरक्षित पहुँच के लिए सेकेंडरी PIN या बायोमेट्रिक का उपयोग करें.\nअतिरिक्त गोपनीयता के लिए वॉल्ट शब्द सक्षम करें और आवश्यकता अनुसार सामग्री छिपाएँ.';

  @override
  String get optionalNote => 'वैकल्पिक नोट';

  @override
  String get password => 'पासवर्ड';

  @override
  String get passwordCopied => 'पासवर्ड कॉपी हुआ';

  @override
  String get patternMismatch => 'पैटर्न मेल नहीं खाए। फिर से शुरू करें';

  @override
  String get pin => 'PIN';

  @override
  String get pinMustBe6Digits => 'PIN 6 अंकों का होना चाहिए';

  @override
  String get pinSaved => 'PIN सहेजा गया';

  @override
  String get pinsDoNotMatch => 'PIN मेल नहीं खाते';

  @override
  String get privateByDesign => 'गोपनीयता एक मूल सिद्धांत है, सुविधा नहीं';

  @override
  String get save => 'सहेजें';

  @override
  String get savePin => 'PIN सहेजें';

  @override
  String get secondaryLock => 'द्वितीयक लॉक';

  @override
  String get security => 'सुरक्षा';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get setPin => 'PIN सेट करें';

  @override
  String get standard => 'मानक';

  @override
  String get strong => 'मजबूत';

  @override
  String vaultHeaderStats(Object collection, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आइटम्स',
      one: 'आइटम',
    );
    return '$collection • $count $_temp0';
  }

  @override
  String get vaultWord => 'वॉल्ट शब्द';

  @override
  String get weak => 'कमज़ोर';

  @override
  String get wrongPattern => 'गलत पैटर्न। फिर से प्रयास करें';

  @override
  String get wrongPin => 'गलत PIN';

  @override
  String get title => 'शीर्षक';

  @override
  String get unlock => 'अनलॉक';

  @override
  String get unlockContent => 'सामग्री अनलॉक करें';

  @override
  String get unlockVault => 'वॉल्ट अनलॉक करें';

  @override
  String get untitled => 'बिना शीर्षक';

  @override
  String updatedDate(Object date) {
    return '$date को अपडेट किया गया';
  }

  @override
  String get username => 'उपयोगकर्ता नाम';

  @override
  String get usernameCopied => 'उपयोगकर्ता नाम कॉपी हुआ';

  @override
  String get usernameEmail => 'उपयोगकर्ता नाम / ईमेल';
}
