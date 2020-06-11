import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:udschallengeapp/app/modules/create_account/create_account_page.dart';

main() {
  testWidgets('CreateAccountPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestableWidget(CreateAccountPage(title: 'CreateAccount')));
    final titleFinder = find.text('CreateAccount');
    expect(titleFinder, findsOneWidget);
  });
}
