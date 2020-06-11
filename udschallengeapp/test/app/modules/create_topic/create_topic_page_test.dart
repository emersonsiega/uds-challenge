import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:udschallengeapp/app/modules/create_topic/create_topic_page.dart';

main() {
  testWidgets('CreateTopicPage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(CreateTopicPage(title: 'CreateTopic')));
    final titleFinder = find.text('CreateTopic');
    expect(titleFinder, findsOneWidget);
  });
}
