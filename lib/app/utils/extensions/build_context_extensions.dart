import 'package:warranty_watch/app/app_library.dart';

extension BuildContextUtils on BuildContext {
  ThemeData get themeData => Theme.of(this);
  TextTheme get textTheme => themeData.textTheme;
  ColorScheme get colorScheme => themeData.colorScheme;
}
