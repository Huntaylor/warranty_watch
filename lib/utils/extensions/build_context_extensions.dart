import 'package:warranty_keeper/app_library.dart';

extension BuildContextUtils on BuildContext {
  /// Returns the instance of AppLocalizations in the Widget tree.
  ///
  /// Note that we are asserting that this value is NOT null because
  /// we are certain that it will exist.
  AppLocalizations get appLocalizations => AppLocalizations.of(this)!;

  ThemeData get themeData => Theme.of(this);
  TextTheme get textTheme => themeData.textTheme;
  ColorScheme get colorScheme => themeData.colorScheme;
  NavigatorState get navigator => Navigator.of(this);
}
