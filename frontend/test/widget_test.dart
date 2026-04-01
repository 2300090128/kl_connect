import 'package:flutter_test/flutter_test.dart';

import 'package:klconnect/main.dart';

void main() {
  testWidgets('App shows splash then navigates to login',
      (WidgetTester tester) async {
    await tester.pumpWidget(const KLConnectApp());

    // Initial splash content.
    expect(find.text('KLConnect'), findsOneWidget);
    expect(find.text('News & Campus App'), findsOneWidget);

    // Splash screen auto-navigates to login after 2 seconds.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.textContaining('Welcome Back'), findsOneWidget);
    expect(find.text('Login to continue'), findsOneWidget);
  });
}
