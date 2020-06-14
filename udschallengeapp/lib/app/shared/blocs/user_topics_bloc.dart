import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/blocs/user_session_bloc.dart';
import 'package:udschallengeapp/app/shared/model/topic_model.dart';
import 'package:udschallengeapp/app/shared/repositories/topic_repository.dart';

class UserTopicsBloc extends BlocBase {
  List<TopicModel> _opened = [];
  List<TopicModel> _closed = [];
  final _openedController = BehaviorSubject<List<TopicModel>>();
  final _closedController = BehaviorSubject<List<TopicModel>>();

  ValueStream<List<TopicModel>> get openedTopicsStream =>
      _openedController.stream;
  ValueStream<List<TopicModel>> get closedTopicsStream =>
      _closedController.stream;

  void loadTopics() {
    final _repo = AppModule.to.getDependency<TopicRepository>();
    final _userSessionBloc = AppModule.to.bloc<UserSessionBloc>();

    final user = _userSessionBloc.userStream.value;

    _repo.findByUser(user.key, _onTopicAdded, _onTopicChanged);
  }

  void clearTopics() {
    _opened.clear();
    _openedController.sink.add(_opened);

    _closed.clear();
    _closedController.sink.add(_closed);
  }

  void _onTopicAdded(Event event) {
    final topicAdded = _topicFromEvent(event);

    if (topicAdded.closed) {
      _closed.add(topicAdded);
      _sortList(_closed);
      _closedController.sink.add(_closed);
    } else {
      _opened.add(topicAdded);
      _sortList(_opened);
      _openedController.sink.add(_opened);
    }
  }

  ///
  /// As Topics are splitted into two different lists, when a Topic is changed,
  /// we need to verify the it's status and, then, if the status was changed, we
  /// need to remove from the previous list and add into the new list, for the
  /// given status.
  ///
  void _onTopicChanged(Event event) {
    final topicChanged = _topicFromEvent(event);

    // Defines the base and target auxiliary variables
    List removeList;
    BehaviorSubject removeController;
    List targetList;
    BehaviorSubject targetController;

    if (topicChanged.closed) {
      removeList = _opened;
      removeController = _openedController;
      targetList = _closed;
      targetController = _closedController;
    } else {
      removeList = _closed;
      removeController = _closedController;
      targetList = _opened;
      targetController = _openedController;
    }

    // Remove from the previous list, if the opened/closed status changed
    final removeIndex = _getIndex(removeList, topicChanged);
    if (removeIndex >= 0) {
      removeList.removeAt(removeIndex);
      _sortList(removeList);
      removeController.sink.add(removeList);
    }

    // Replace the entry from the correct list or add a new entry
    final editIndex = _getIndex(targetList, topicChanged);
    if (editIndex < 0) {
      targetList.add(topicChanged);
    } else {
      targetList[editIndex] = topicChanged;
    }
    _sortList(targetList);
    targetController.sink.add(targetList);
  }

  int _getIndex(List<TopicModel> topicsList, TopicModel topic) {
    return topicsList.indexWhere(
      (topicFromList) => topicFromList.key == topic.key,
    );
  }

  TopicModel _topicFromEvent(Event event) {
    final key = event.snapshot.key;
    final topicMac = Map<String, dynamic>.from(event.snapshot.value);
    return TopicModel.fromJson(key, topicMac);
  }

  void _sortList(List<TopicModel> list) {
    list.sort(
      (TopicModel base, TopicModel other) =>
          other.createdAt.compareTo(base.createdAt),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _openedController.close();
    _closedController.close();
  }
}
