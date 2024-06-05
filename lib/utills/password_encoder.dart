import 'dart:convert';

import 'package:crypto/crypto.dart';

String encodePasswordWithMD5(String password) {
  var bytes = utf8.encode(password); // Convert password to bytes
  var digest = md5.convert(bytes); // Perform MD5 hash
  return digest.toString(); // Convert hash to string
}

bool verifyPassword(String inputPassword, String storedHash) {
  String inputHash = encodePasswordWithMD5(inputPassword);
  return inputHash == storedHash;
}
