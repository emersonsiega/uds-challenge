import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:udschallengeapp/app/modules/recover_password/recover_password_page.dart';

main() {
  testWidgets('RecoverPasswordPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(
        buildTestableWidget(RecoverPasswordPage(title: 'RecoverPassword')));
    final titleFinder = find.text('RecoverPassword');
    expect(titleFinder, findsOneWidget);
  });
}
