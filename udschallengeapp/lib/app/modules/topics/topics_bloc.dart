import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/topic_model.dart';
import 'package:udschallengeapp/app/shared/repositories/topic_repository.dart';

class TopicsBloc extends BlocBase {
  Future<void> changeStatus(TopicModel topic, bool futureStatus) async {
    try {
      final _repository = AppModule.to.getDependency<TopicRepository>();

      topic.closed = futureStatus;

      await _repository.update(topic);
    } catch (ex) {
      print(ex);
      throw new InvalidRequestException("Não foi possível alterar a pauta");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
