import 'package:warranty_keeper/app_library.dart';

extension BuildContextUtils on BuildContext {
  AppLocalizations get appLocalizations => AppLocalizations.of(this)!;

  ThemeData get themeData => Theme.of(this);
  TextTheme get textTheme => themeData.textTheme;
  ColorScheme get colorScheme => themeData.colorScheme;
  NavigatorState get navigator => Navigator.of(this);
}
