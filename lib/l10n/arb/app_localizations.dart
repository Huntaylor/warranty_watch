import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Main title
  ///
  /// In en, this message translates to:
  /// **'Warranty Watch'**
  String get mainTitle;

  /// Text for Current warranties button on Home View
  ///
  /// In en, this message translates to:
  /// **'Current Warranties'**
  String get currentWarrantyBtn;

  /// Text for new warranties button on Home View
  ///
  /// In en, this message translates to:
  /// **'New Warranty'**
  String get newWarrantyBtn;

  /// Title for Add Warranty View
  ///
  /// In en, this message translates to:
  /// **'Add Warranty'**
  String get addWarrantyTitle;

  /// Title for Edit Warranty View
  ///
  /// In en, this message translates to:
  /// **'Edit Warranty'**
  String get editWarrantyTitle;

  /// Text for Create Account
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Text for add new warranty product
  ///
  /// In en, this message translates to:
  /// **'Name of product'**
  String get productName;

  /// Text for add product button
  ///
  /// In en, this message translates to:
  /// **'Add product'**
  String get addproductButton;

  /// Text for edit product button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get editProductBtn;

  /// Text for Life time Warranty
  ///
  /// In en, this message translates to:
  /// **'Lifetime Warranty'**
  String get lifetime;

  /// Text for Date of product Purchased
  ///
  /// In en, this message translates to:
  /// **'Date of product Purchased'**
  String get purchaseDate;

  /// Hint Text for text fields
  ///
  /// In en, this message translates to:
  /// **'Type here...'**
  String get typeHere;

  /// Text for Additional details form
  ///
  /// In en, this message translates to:
  /// **'Additional Details'**
  String get additionalDetails;

  /// Text for last day of the Warranty
  ///
  /// In en, this message translates to:
  /// **'Warranty End Date'**
  String get expirationDate;

  /// Text for required textfields
  ///
  /// In en, this message translates to:
  /// **'(Required)'**
  String get requiredText;

  /// Text for adding a photo
  ///
  /// In en, this message translates to:
  /// **'Tap to add a Photo'**
  String get addPhoto;

  /// Text for adding a receipt
  ///
  /// In en, this message translates to:
  /// **'Tap to add a receipt'**
  String get addReceipt;

  /// Text for cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Text for bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Add an image'**
  String get addItem;

  /// Text for bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// Text for bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// Text for bottom sheet
  ///
  /// In en, this message translates to:
  /// **'No Warranties'**
  String get noCurrentWarranties;

  /// Text for purchased on detail
  ///
  /// In en, this message translates to:
  /// **'Purchased on'**
  String get purchasedOn;

  /// text for expires on details
  ///
  /// In en, this message translates to:
  /// **'Warranty expires {timeLeft} on {date}'**
  String expiresOn(Object timeLeft, Object date);

  /// text for reminder details
  ///
  /// In en, this message translates to:
  /// **'You will receive a reminder {reminderTime} on {date}'**
  String remindsOn(Object reminderTime, Object date);

  /// Text for no reminders set
  ///
  /// In en, this message translates to:
  /// **'Reminders not set'**
  String get noReminderSet;

  /// Text for details
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// Text for product website details
  ///
  /// In en, this message translates to:
  /// **'Product Website'**
  String get productWebsite;

  /// Text for Receipt Photo details
  ///
  /// In en, this message translates to:
  /// **'Receipt Photo'**
  String get receiptPhoto;

  /// Text for lifetime warranty details
  ///
  /// In en, this message translates to:
  /// **'Has Lifetime Warranty'**
  String get hasLifetime;

  /// Text for edit details
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Text for remove details
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// text for product name details
  ///
  /// In en, this message translates to:
  /// **'Product: {productName}'**
  String detailsName(Object productName);

  /// text for purchase date details
  ///
  /// In en, this message translates to:
  /// **'Purchased on: {purchaseDate}'**
  String purchaseDateDetails(Object purchaseDate);

  /// text for expiration date details
  ///
  /// In en, this message translates to:
  /// **'Expires On: {expirationDate}'**
  String expirationDetailsDate(Object expirationDate);

  /// Text for expiring widget title
  ///
  /// In en, this message translates to:
  /// **'Expiring Soon'**
  String get expiringSoon;

  /// Text for expiring widget date format
  ///
  /// In en, this message translates to:
  /// **'MM/DD/YYYY'**
  String get dateFormat;

  /// Text for expiring widget empty
  ///
  /// In en, this message translates to:
  /// **'No warranties close to expiration'**
  String get noneExpiring;

  /// Text for back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Text for expiring warranties error
  ///
  /// In en, this message translates to:
  /// **'There was an issue loading your expiring warranties. Please try again later.'**
  String get expiringError;

  /// Error text for create account email check
  ///
  /// In en, this message translates to:
  /// **'This email is already in use'**
  String get emailError;

  /// Title for Create Account Name Fields
  ///
  /// In en, this message translates to:
  /// **'What is your name?'**
  String get nameFieldTitle;

  /// Hint for Create Account Name Fields, First name
  ///
  /// In en, this message translates to:
  /// **'First'**
  String get first;

  /// Hint for Create Account Name Fields, Last name
  ///
  /// In en, this message translates to:
  /// **'Last'**
  String get last;

  /// Title for Create Account Email Field
  ///
  /// In en, this message translates to:
  /// **'What is your email?'**
  String get emailFieldTitle;

  /// Title for Create Account Password Field
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get passwordFieldTitle;

  /// Hint for Create Account Password Fields, Password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// Hint for Create Account Password Fields, Password
  ///
  /// In en, this message translates to:
  /// **'Re-Enter Password'**
  String get confirmPasswordHint;

  /// Title for Create Account Password Fields, Confirm Password
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordFieldTitle;

  /// Password Creation Rule 1
  ///
  /// In en, this message translates to:
  /// **'6 characters or more'**
  String get passwordRule1;

  /// Password Creation Rule 2
  ///
  /// In en, this message translates to:
  /// **'A lower and upper case letter'**
  String get passwordRule2;

  /// Password Creation Rule 3
  ///
  /// In en, this message translates to:
  /// **'A number'**
  String get passwordRule3;

  /// Password Creation Rule 4
  ///
  /// In en, this message translates to:
  /// **'A special character'**
  String get passwordRule4;

  /// Password Creation Rule 5
  ///
  /// In en, this message translates to:
  /// **'Passwords must match'**
  String get passwordRule5;

  /// Title for Password Creation Rules
  ///
  /// In en, this message translates to:
  /// **'Your Password must contain:'**
  String get passwordRuleTitle;

  /// Title for Terms and Conditions
  ///
  /// In en, this message translates to:
  /// **'By creating an account you agree to the terms and conditions of this app '**
  String get tosTitle;

  /// Continuation for Terms and Conditions, link button
  ///
  /// In en, this message translates to:
  /// **'available here'**
  String get tosTitleContinue;

  /// Text for Terms and Conditions checkbox
  ///
  /// In en, this message translates to:
  /// **'I accept the terms and conditions'**
  String get tosAcceptanceText;

  /// Title for login Create Account options
  ///
  /// In en, this message translates to:
  /// **'Choose one to Create an Account'**
  String get loginCreateTitle;

  /// Title for login Create Account options
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButtonText;

  /// Title for login Create Account options
  ///
  /// In en, this message translates to:
  /// **'Account Email'**
  String get loginEmailFieldTitle;

  /// Title for login Create Account options
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get loginPasswordFieldTitle;

  /// Text for Forgot Password button
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordText;

  /// Warning text used in Settings
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone. Since this is a security-sensitive operation, you might be asked to login'**
  String get settingsWarning;

  /// No description provided for @resetPasswordError.
  ///
  /// In en, this message translates to:
  /// **'There was an issue while attempting to reset your password. {error}'**
  String resetPasswordError(String error);

  /// No description provided for @getImageError.
  ///
  /// In en, this message translates to:
  /// **'There was an issue getting your image. Please try again or use a different image.'**
  String get getImageError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
