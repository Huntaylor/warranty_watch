import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLaunchHelper {
  UrlLaunchHelper._();
  static final Logger _log = Logger('URL Launch Helper');

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
      _log.log(Level.WARNING, 'Launch URL', e, stacktrace);
      return false;
    }
  }
}
