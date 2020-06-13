import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:udschallengeapp/app/shared/model/topic_model.dart';

class TopicRepository extends Disposable {
  final _database = FirebaseDatabase.instance;
  List<StreamSubscription> _subscriptions = [];

  Future<TopicModel> save(TopicModel topic) async {
    final reference = _database.reference().child(TopicModel.collection).push();

    await reference.set(topic.toJson());

    topic.key = reference.key;

    return topic;
  }

  void findByUser(
    String userKey,
    void Function(Event) onChildAdded,
    void Function(Event) onChildChanged,
  ) {
    Query query = _database
        .reference()
        .child(TopicModel.collection)
        .orderByChild("userKey")
        .equalTo(userKey);

    final addedSubscription = query.onChildAdded.listen(onChildAdded);
    _subscriptions.add(addedSubscription);

    final changedSubscription = query.onChildChanged.listen(onChildChanged);
    _subscriptions.add(changedSubscription);
  }

  @override
  void dispose() {
    _subscriptions.forEach(
      (subscription) => subscription.cancel(),
    );
  }
}
