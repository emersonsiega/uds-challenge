import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:udschallengeapp/app/modules/topics/topics_page.dart';

main() {
  testWidgets('TopicsPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(TopicsPage(title: 'Topics')));
    final titleFinder = find.text('Topics');
    expect(titleFinder, findsOneWidget);
  });
}
