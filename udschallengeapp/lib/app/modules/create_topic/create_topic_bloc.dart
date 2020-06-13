import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/blocs/user_session_bloc.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/topic_model.dart';
import 'package:udschallengeapp/app/shared/repositories/topic_repository.dart';

class CreateTopicBloc extends BlocBase {
  Future<TopicModel> save(TopicModel topic) async {
    try {
      final _repo = AppModule.to.getDependency<TopicRepository>();
      final _sessionBloc = AppModule.to.getBloc<UserSessionBloc>();

      final user = _sessionBloc.userStream.value;

      topic.userKey = user.key;
      topic.createdAt = DateTime.now();

      return await _repo.save(topic);
    } catch (ex) {
      print(ex);
      throw new InvalidRequestException("Não foi possível criar a pauta");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
