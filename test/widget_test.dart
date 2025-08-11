import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/claims_model.dart';
import 'package:flutter_application_test/view/claim_card.dart';
import 'package:flutter_test/flutter_test.dart';

// ===== WIDGET UNIT TESTS =====
void main() {
  group('ClaimCard Widget', () {
    testWidgets('ClaimCard displays the correct claim information', (
      WidgetTester tester,
    ) async {
      // Define a mock claim object to use for testing.
      const testClaim = Claim(
        userId: 1,
        id: 101,
        title: 'Test Claim Title',
        body: 'This is the body of the test claim.',
      );

      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ClaimCard(claim: testClaim))),
      );

      // Verify that the title is present in the widget tree.
      expect(find.text('Test Claim Title'), findsOneWidget);

      // Verify that the claim ID is present.
      expect(find.text('Claim ID: 101'), findsOneWidget);

      // Verify that the claimant ID is present.
      expect(find.text('Claimant ID: 1'), findsOneWidget);

      // Verify that the body text is present.
      expect(find.text('This is the body of the test claim.'), findsOneWidget);

      // We can also test for the absence of widgets.
      expect(find.text('This text should not be here.'), findsNothing);
    });
  });
}
