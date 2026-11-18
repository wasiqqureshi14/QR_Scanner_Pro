class QRService {
  QRService._();

  static bool isValidContent(String content) {
    return content.trim().isNotEmpty;
  }

  static String cleanContent(String content) {
    return content.trim();
  }

  static bool isUrl(String content) {
    final uri = Uri.tryParse(content.trim());

    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  static String getContentType(String content) {
    return isUrl(content) ? 'URL' : 'Text';
  }
}
