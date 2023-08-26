import 'package:url_launcher/url_launcher_string.dart';
import 'package:warranty_watch/app/app_library.dart';

class UrlLaunchHelper {
  UrlLaunchHelper._();

  static Future<bool> launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(
          url,
        );
        return true;
      }
      return false;
    } catch (e, stacktrace) {
      debugPrint('''
      ---- UrlLaunchHelper : tryLaunch ----
      $e
      $stacktrace
      ''');
      return false;
    }
  }
}
