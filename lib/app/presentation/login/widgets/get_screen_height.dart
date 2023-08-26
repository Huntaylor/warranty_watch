import 'package:warranty_watch/app/app_library.dart';

double getAvailableScreenHeight(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final statusBarHeight = MediaQuery.of(context).padding.top;
  final navigationBarHeight = MediaQuery.of(context).padding.bottom;
  final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
  return screenHeight - statusBarHeight - navigationBarHeight - keyboardHeight;
}
