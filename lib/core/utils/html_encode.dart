import 'package:html_unescape/html_unescape.dart';

class HtmlEncode {
  static HtmlUnescape htmlUnescape = HtmlUnescape();

  static String encode(String text) {
    return htmlUnescape.convert(text);
  }
}
