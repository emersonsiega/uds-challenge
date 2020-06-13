import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:udschallengeapp/app/shared/model/user_model.dart';

class UserRepository extends Disposable {
  final _database = FirebaseDatabase.instance;

  Future<UserModel> save(UserModel user) async {
    final reference = _database.reference().child(UserModel.collection).push();

    await reference.set(user.toJson());

    user.key = reference.key;

    return user;
  }

  ///
  /// Find a single [UserModel] by the given [field] (default field is "email")
  ///
  Future<UserModel> find(String value, {String field: "email"}) async {
    Query query = _database
        .reference()
        .child(UserModel.collection)
        .orderByChild(field)
        .equalTo(value);

    final snapshot = await query.once();

    if (snapshot.value != null) {
      final Map map = snapshot.value;
      final key = map.keys.first;

      return UserModel.fromSnapshot(
        key,
        map[key],
      );
    }

    return null;
  }

  @override
  void dispose() {}
}
