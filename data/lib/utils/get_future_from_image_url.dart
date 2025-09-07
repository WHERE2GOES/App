import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future<Uint8List?> getFutureFromImageUrl(String url) {
  return http.get(Uri.parse(url)).then((res) => res.bodyBytes);
}
