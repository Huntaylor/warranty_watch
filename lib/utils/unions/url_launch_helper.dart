import 'package:url_launcher/url_launcher.dart';

class UrlLaunchHelper {
  UrlLaunchHelper._();

  static Future<bool> launchURL(String url) async {
    try {
      if (await canLaunchUrl(url)) {
        await launch(
          url,
          enableJavaScript: true,
          forceSafariVC: true,
          forceWebView: true,
        );
        return true;
      }
      return false;
    } catch (e, stacktrace) {
      print('''
      ---- UrlLaunchHelper : tryLaunch ----
      $e
      $stacktrace
      ''');
      return false;
    }
  }
}
