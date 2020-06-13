import 'package:udschallengeapp/app/shared/model/topics_page/topics_page_type.dart';

class TopicsPageArguments {
  final String title;
  final TopicsPageType type;

  TopicsPageArguments({
    this.title: "",
    this.type: TopicsPageType.opened,
  });
}
