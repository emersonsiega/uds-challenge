import 'package:encrypt/encrypt.dart';

class PasswordEncryptionUtils {
  static final _key = Key.fromUtf8('mega-hyper-ultra-power-32charkey');
  static final _iv = IV.fromLength(16);

  static String encrypt(String password) {
    final encrypter = Encrypter(AES(_key));

    final encrypted = encrypter.encrypt(password, iv: _iv);

    return encrypted.base64;
  }

  static String decrypt(String base64Pwd) {
    final encrypter = Encrypter(AES(_key));

    return encrypter.decrypt64(base64Pwd, iv: _iv);
  }
}
