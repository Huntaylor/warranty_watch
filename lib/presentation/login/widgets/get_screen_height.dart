import 'package:warranty_keeper/app_library.dart';

double getAvailableScreenHeight(BuildContext context) {
  final double screenHeight = MediaQuery.of(context).size.height;
  final double statusBarHeight = MediaQuery.of(context).padding.top;
  final double navigationBarHeight = MediaQuery.of(context).padding.bottom;
  final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
  return screenHeight - statusBarHeight - navigationBarHeight - keyboardHeight;
}
