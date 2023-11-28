import 'dart:developer';

import 'package:url_launcher/url_launcher_string.dart';

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
      log(e.toString(), stackTrace: stacktrace);
      return false;
    }
  }
}
