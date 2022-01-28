import 'dart:convert';

import 'package:crypto/crypto.dart';

abstract class EncodeUtils {
  static String encodeSHA(String data) {
    var bytes = utf8.encode(data); // data being hashed

    var digest = sha256.convert(bytes);

    return digest.toString();
  }

  static String encodeBase64(String value) {
    return base64.encode(utf8.encode(value));
  }

  static String decodeBase64(String encoded) {
    return utf8.decode(base64.decode(encoded));
  }

  static String encodeUri(String url) {
    return Uri.encodeFull(url);
  }
}
