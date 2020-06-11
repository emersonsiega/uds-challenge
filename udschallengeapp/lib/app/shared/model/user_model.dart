import 'package:udschallengeapp/app/shared/utils/password_encryption_utils.dart';

class UserModel {
  static const String collection = "users";

  String key;
  String authId;
  String name;
  String email;
  String password;

  UserModel({
    this.key,
    this.authId,
    this.name,
    this.email,
    this.password,
  });

  String get _encryptedPwd => PasswordEncryptionUtils.encrypt(password);

  String _decryptedPwd(String pwd) => PasswordEncryptionUtils.decrypt(pwd);

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();
    data['authId'] = this.authId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this._encryptedPwd;

    return data;
  }

  UserModel.fromSnapshot(String key, final Map map) {
    this.key = key;
    authId = map['authId'];
    name = map['name'];
    email = map['email'];
    String pwd = map['password'];
    password = _decryptedPwd(pwd);
  }
}
