// This is a basic Flutter widgets test.
//
// To perform an interaction with a widgets in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widgets
// tree, read text, and verify that the values of widgets properties are correct.

import 'package:crypto_portfolio_tracker/data/local/local_storage.dart';
import 'package:crypto_portfolio_tracker/data/repositories/crypto_repository.dart';
import 'package:crypto_portfolio_tracker/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crypto_portfolio_tracker/main.dart';

import '../lib/app/app.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final repository = CryptoRepository(ApiService(), LocalStorage());

    // Build our app and trigger a frame
    await tester.pumpWidget(MyApp(repository: repository));
    // Build our app and trigger a frame.
    // await tester.pumpWidget(const MyApp());
    expect(find.text('Crypto Portfolio'), findsNothing);
    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
