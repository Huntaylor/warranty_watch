// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get mainTitle => 'Warranty Watch';

  @override
  String get currentWarrantyBtn => 'Current Warranties';

  @override
  String get newWarrantyBtn => 'New Warranty';

  @override
  String get addWarrantyTitle => 'Add Warranty';

  @override
  String get editWarrantyTitle => 'Edit Warranty';

  @override
  String get createAccount => 'Create Account';

  @override
  String get productName => 'Name of product';

  @override
  String get addproductButton => 'Add product';

  @override
  String get editProductBtn => 'Save';

  @override
  String get lifetime => 'Lifetime Warranty';

  @override
  String get purchaseDate => 'Date of product Purchased';

  @override
  String get typeHere => 'Type here...';

  @override
  String get additionalDetails => 'Additional Details';

  @override
  String get expirationDate => 'Warranty End Date';

  @override
  String get requiredText => '(Required)';

  @override
  String get addPhoto => 'Tap to add a Photo';

  @override
  String get addReceipt => 'Tap to add a receipt';

  @override
  String get cancel => 'Cancel';

  @override
  String get addItem => 'Add an image';

  @override
  String get camera => 'Camera';

  @override
  String get photos => 'Photos';

  @override
  String get noCurrentWarranties => 'No Warranties';

  @override
  String get purchasedOn => 'Purchased on';

  @override
  String expiresOn(Object timeLeft, Object date) {
    return 'Warranty expires $timeLeft on $date';
  }

  @override
  String remindsOn(Object reminderTime, Object date) {
    return 'You will receive a reminder $reminderTime on $date';
  }

  @override
  String get noReminderSet => 'Reminders not set';

  @override
  String get details => 'Details';

  @override
  String get productWebsite => 'Product Website';

  @override
  String get receiptPhoto => 'Receipt Photo';

  @override
  String get hasLifetime => 'Has Lifetime Warranty';

  @override
  String get edit => 'Edit';

  @override
  String get remove => 'Remove';

  @override
  String detailsName(Object productName) {
    return 'Product: $productName';
  }

  @override
  String purchaseDateDetails(Object purchaseDate) {
    return 'Purchased on: $purchaseDate';
  }

  @override
  String expirationDetailsDate(Object expirationDate) {
    return 'Expires On: $expirationDate';
  }

  @override
  String get expiringSoon => 'Expiring Soon';

  @override
  String get dateFormat => 'MM/DD/YYYY';

  @override
  String get noneExpiring => 'No warranties close to expiration';

  @override
  String get back => 'Back';

  @override
  String get expiringError =>
      'There was an issue loading your expiring warranties. Please try again later.';

  @override
  String get emailError => 'This email is already in use';

  @override
  String get nameFieldTitle => 'What is your name?';

  @override
  String get first => 'First';

  @override
  String get last => 'Last';

  @override
  String get emailFieldTitle => 'What is your email?';

  @override
  String get passwordFieldTitle => 'Create Password';

  @override
  String get passwordHint => 'Password';

  @override
  String get confirmPasswordHint => 'Re-Enter Password';

  @override
  String get confirmPasswordFieldTitle => 'Confirm Password';

  @override
  String get passwordRule1 => '6 characters or more';

  @override
  String get passwordRule2 => 'A lower and upper case letter';

  @override
  String get passwordRule3 => 'A number';

  @override
  String get passwordRule4 => 'A special character';

  @override
  String get passwordRule5 => 'Passwords must match';

  @override
  String get passwordRuleTitle => 'Your Password must contain:';

  @override
  String get tosTitle =>
      'By creating an account you agree to the terms and conditions of this app ';

  @override
  String get tosTitleContinue => 'available here';

  @override
  String get tosAcceptanceText => 'I accept the terms and conditions';

  @override
  String get loginCreateTitle => 'Choose one to Create an Account';

  @override
  String get loginButtonText => 'Login';

  @override
  String get loginEmailFieldTitle => 'Account Email';

  @override
  String get loginPasswordFieldTitle => 'Enter Password';

  @override
  String get forgotPasswordText => 'Forgot Password?';

  @override
  String get settingsWarning =>
      'This cannot be undone. Since this is a security-sensitive operation, you might be asked to login';

  @override
  String resetPasswordError(String error) {
    return 'There was an issue while attempting to reset your password. $error';
  }

  @override
  String get getImageError =>
      'There was an issue getting your image. Please try again or use a different image.';
}
